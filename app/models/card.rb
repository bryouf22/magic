# frozen_string_literal: true

# == Schema Information
#
# Table name: cards
#
#  id                  :bigint           not null, primary key
#  name                :string
#  extension_set_id    :integer
#  card_type           :integer
#  detailed_type       :string
#  rarity              :integer
#  text                :text
#  cmc                 :integer
#  mana_cost           :string
#  color_ids           :integer          is an Array
#  image               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  artist_name         :string
#  number_in_set       :integer
#  gatherer_link       :string
#  gatherer_id         :integer
#  name_clean          :string
#  flavor_text         :text
#  power_str           :string
#  defense_str         :string
#  color_indicator     :string
#  loyalty             :integer
#  format              :integer          default(0), not null
#  first_edition       :boolean
#  is_double_card      :boolean          default(FALSE)
#  is_double_part      :boolean          default(FALSE)
#  hybrid              :boolean          default(FALSE)
#  alternative_type    :integer          default("no_double")
#  legend              :boolean          default(FALSE)
#  snow                :boolean          default(FALSE)
#  tribal              :boolean          default(FALSE)
#  subtypes            :string
#  has_image           :boolean
#  frame_type          :integer          default("classic"), not null
#  specific_frame_type :string
#  set_extra_card      :boolean
#

class Card < ApplicationRecord
  include Bitfields

  # TODO : ajouter bitfield pour le format (https://github.com/grosser/bitfields)
  bitfield :format, 1 => :modern, 2 => :legacy, 4 => :standard, 8 => :commander

  scope :only_green,              -> { where(color_ids: [Color.green]).where.not(alternative_type: :double_card).where.not(is_double_part: true) }
  scope :only_red,                -> { where(color_ids: [Color.red]).where.not(alternative_type: :double_card).where.not(is_double_part: true)   }
  scope :only_blue,               -> { where(color_ids: [Color.blue]).where.not(alternative_type: :double_card).where.not(is_double_part: true)  }
  scope :only_white,              -> { where(color_ids: [Color.white]).where.not(alternative_type: :double_card).where.not(is_double_part: true) }
  scope :only_black,              -> { where(color_ids: [Color.black]).where.not(alternative_type: :double_card).where.not(is_double_part: true) }
  scope :gold,                    -> { where('array_length(color_ids, 1) >= 2').where(is_double_part: false) }
  scope :gold_not_hybrids,        -> { where('array_length(color_ids, 1) >= 2').not_hybrids.where(is_double_part: false) }
  scope :basic_lands,             -> { where(name: BASIC_LANDS_NAMES) }
  scope :colorless,               -> { where(color_ids: nil) }
  scope :colorless_artefact,      -> { where(color_ids: nil).artefacts }
  scope :colorless_non_artefact,  -> { colorless.where('cards.card_type NOT IN (2, 5, 6, 11) OR cards.card_type IS NULL') }
  scope :red,                     -> { where('ANY(color_ids) = ?', Color.red) }
  scope :blue,                    -> { where('ANY(color_ids) = ?', Color.blue) }
  scope :black,                   -> { where('ANY(color_ids) = ?', Color.black) }
  scope :green,                   -> { where('ANY(color_ids) = ?', Color.green) }
  scope :white,                   -> { where('ANY(color_ids) = ?', Color.white) }
  scope :artefacts,               -> { where(card_type: [5, 6, 13, 14]) }
  scope :creatures,               -> { where(card_type: [4, 6]) }
  scope :others,                  -> { where(card_type: [1, 3, 5, 6, 7, 8, 9, 10, nil]) }
  scope :lands,                   -> { where(card_type: [2, 12]) }
  scope :doubles,                 -> { where(alternative_type: :double_card) }
  scope :not_hybrids,             -> { where(hybrid: [false, nil]) }
  scope :hybrids,                 -> { where(hybrid: true) }
  scope :tribals,                 -> { where(tribal: true) }
  scope :legends,                 -> { where(legend: true) }
  scope :snows,                   -> { where(snow:   true) }
  scope :not_double,              -> { where.not(is_double_card: true, is_double_part: true) }

  enum card_type: {
    instant: 1,
    land: 2,
    sorcery: 3,
    creature: 4,
    artifact: 5,
    creature_artifact: 6,
    enchantment: 7,
    planeswalker: 8,
    enchantment_creature: 9,
    other: 10,
    token: 11,
    creature_land: 12,
    artifact_land: 13,
    enchantment_artifact: 14
  }

  enum rarity: {
    common: 1,
    uncommon: 2,
    rare: 3,
    mythic: 4,
    timeshifted: 5
  }

  enum alternative_type: {
    no_double: 0,
    recto_verso: 1,
    double_card: 2,
    flip_card: 3,
    adventure: 4,
    two_part: 5, # ex Big furry monster
    partenair: 6  # ex Battlebond edition
  }

  enum frame_type: {
    classic: 0,
    extended_art: 1,
    borderless: 2,
    showcase: 3,
    promo_pack: 4,
    bundle: 5,
    specific: 6
  }

  belongs_to :extension_set

  has_one :alternative
  has_one :alternative_card, through: :alternative

  has_many :alternate_frames
  has_many :reprints, foreign_key: :card_id, dependent: :destroy
  has_many :reprint_cards, through: :reprints

  before_create :set_colors, :clean_names, :set_type, :set_hybrid
  before_save :set_type, if: :will_save_change_to_detailed_type?
  before_save :rename, if: proc { |card| card.has_alternative? && !card.name.include?('/') }

  mount_uploader :image, CardImageUploader

  validates_uniqueness_of :gatherer_id, unless: proc { |c| c.gatherer_id.nil? || c.has_alternative? || c.alternative? }

  BASIC_LANDS_NAMES = [
    'Snow-Covered Island',
    'Snow-Covered Swamp',
    'Snow-Covered Mountain',
    'Snow-Covered Forest',
    'Snow-Covered Plains',
    'Island',
    'Swamp',
    'Mountain',
    'Forest',
    'Plains'
  ].freeze

  def has_alternative?
    alternative.present?
  end

  def alternative?
    Alternative.where(alternative_card: id).any?
  end

  def colorless?
    !color_ids.present?
  end

  def colors
    return [] unless color_ids.present?
    colors = []
    color_ids.each do |id|
      colors << Color::COLORS_MAPPING.invert[id].to_s
    end
    colors
  end

  def card_ids
    reprint_cards.collect(&:id) << id
  end

  def basic_land?
    BASIC_LANDS_NAMES.include?(name)
  end

  def set_type!
    set_type
    save
  end

  def self.all_subtypes
    @subtypes_result ||= begin
      subtypes_result = []
      all.collect(&:subtypes).uniq.compact.each do |sub_type|
        sub_type.split(' ').each do |s|
          subtypes_result << s unless subtypes_result.include?(s)
        end
      end
      subtypes_result.reject do |value|
        # TODO : remove value like Wrenn, Xenagos, Urza, etc
        ['The', 'and/or', 'of'].include?(value) || Card::BASIC_LANDS_NAMES.include?(value)
      end.sort
    end
  end

  def reset_hybrid!
    set_hybrid
    save
  end

  def reset_colors!
    set_colors
    save
  end

  def image_is_present?
    return false unless image.present?

    File.exist?("#{Rails.root}/public#{image_url}")
  end

  def set_has_image!
    self[:has_image] = image_is_present?
    save
  end

  private

  def mana_cost_for_color
    mana_cost.gsub(/Snow/, '')
  end

  def set_hybrid
    self[:hybrid] = if (Color::HYBRID_SYMBOLS & mana_cost_for_color.split('')).present?
                      true
                    else
                      false
                    end
  end

  def clean_names
    self[:name_clean] = I18n.transliterate(name || '').downcase.parameterize
  end

  def set_colors
    c_ids = []
    if color_indicator.present?
      color_indicator.downcase.split(',').each do |color|
        c_ids << Color.__send__(color.gsub(' ', ''))
      end
    else
      Color::MANA_COST_MAPPING.each do |mana_c, colors|
        next unless mana_cost_for_color&.include?(mana_c.to_s)

        Array.wrap(colors).each do |color|
          c_ids << Color.__send__(color)
        end
      end
    end
    self['color_ids'] = c_ids.any? ? c_ids.uniq.sort : nil
  end

  def type_separator
    8212.chr("UTF-8")
  end

  def set_type
    if detailed_type.include?(" #{type_separator} ")
      self.subtypes = detailed_type.split(" #{type_separator} ").last
      c_type = detailed_type.split(" #{type_separator} ").first
    else
      c_type = detailed_type
    end

    self.card_type = :other
    self.card_type = :creature              if c_type.in?(['Creature', 'Summon', 'Eaturecray', 'Legendary Creature', 'Host Creature', 'Snow Creature', 'Scariest Creature You’ll Ever See'])
    self.card_type = :artifact              if c_type.in?(['Artifact', 'Legendary Artifact', 'Tribal Artifact', 'Snow Artifact'])
    self.card_type = :creature_artifact     if c_type.in?(['Legendary Artifact Creature', 'Artifact Creature', 'Host Artifact Creature', 'Snow Artifact Creature'])
    self.card_type = :enchantment_creature  if c_type.in?(['Enchantment Creature', 'Legendary Enchantment Creature'])
    self.card_type = :enchantment           if c_type.in?(['Snow Enchantment', 'Tribal Enchantment', 'Legendary Enchantment', 'Enchantment', 'World Enchantment', 'Legendary Snow Enchantment'])
    self.card_type = :sorcery               if c_type.in?(['Tribal Sorcery', 'Sorcery', 'Legendary Sorcery'])
    self.card_type = :instant               if c_type.in?(['Instant', 'Tribal Instant', 'instant'])
    self.card_type = :planeswalker          if c_type.in?(['Legendary Planeswalker'])
    self.card_type = :land                  if c_type.in?(['Basic Land', 'Basic Snow Land', 'Land', 'Legendary Land', 'Legendary Snow Land', 'Snow Land'])
    self.card_type = :token                 if c_type.in?(['Creature token'])
    self.card_type = :creature_land         if c_type.in?(['Land Creature'])
    self.card_type = :artifact_land         if c_type.in?(['Artifact Land'])
    self.card_type = :enchantment_artifact  if c_type.in?(['Legendary Enchantment Artifact'])
    self.tribal    = true                   if c_type.include?('Tribal')
    self.snow      = true                   if c_type.include?('Snow')
    self.legend    = true                   if c_type.include?('Legendary')
  end

  def rename
    self[:name]       = "#{name} / #{alternative.alternative_card.name}"
    self[:name_clean] = name.parameterize
  end
end
