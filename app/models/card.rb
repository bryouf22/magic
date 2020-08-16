# == Schema Information
#
# Table name: cards
#
#  id               :bigint           not null, primary key
#  name             :string
#  extension_set_id :integer
#  card_type        :integer
#  detailed_type    :string
#  rarity           :integer
#  text             :text
#  cmc              :integer
#  mana_cost        :string
#  color_ids        :integer          is an Array
#  image            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_name      :string
#  number_in_set    :integer
#  gatherer_link    :string
#  gatherer_id      :integer
#  name_clean       :string
#  flavor_text      :text
#  power_str        :string
#  defense_str      :string
#  color_indicator  :string
#  loyalty          :integer
#  format           :integer          default(0), not null
#  first_edition    :boolean
#  is_double_card   :boolean          default(FALSE)
#  is_double_part   :boolean          default(FALSE)
#  hybrid           :boolean          default(FALSE)
#  alternative_type :integer          default("recto_verso")
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
  scope :gold,                    -> { where('array_length(color_ids, 1) >= 2').where(hybrid: false).where(is_double_part: false) }
  scope :colorless,               -> { where('color_ids is ?', nil) }
  scope :red,                     -> { where('? = ANY(color_ids)', Color.red)}
  scope :blue,                    -> { where('? = ANY(color_ids)', Color.blue)}
  scope :black,                   -> { where('? = ANY(color_ids)', Color.black)}
  scope :green,                   -> { where('? = ANY(color_ids)', Color.green)}
  scope :white,                   -> { where('? = ANY(color_ids)', Color.white)}
  scope :colorless_artefact,      -> { where('color_ids is ?', nil).also_artefacts }
  scope :also_artefacts,          -> { where(card_type: [5, 6]) }
  scope :colorless_non_artefact,  -> { colorless.where('cards.card_type NOT IN (2, 5, 6) OR cards.card_type IS NULL') }
  scope :basic_lands,             -> { where('name in (?)', BASIC_LANDS_NAMES) }
  scope :creatures,               -> { where('card_type in (?)', [4, 6]) }
  scope :others,                  -> { where('card_type in (?)', [1, 3, 5, 6, 7, 8, 9, 10, nil]) }
  scope :hybrids,                 -> { where(hybrid: true) }
  scope :doubles,                 -> { where(alternative_type: :double_card) }

  enum card_type: {
    instant:            1,
    land:               2,
    sorcery:            3,
    creature:           4,
    artifact:           5,
    creature_artifact:  6,
    enchantement:       7,
    planeswalker:       8,
    tribal:             9,
    other:              10
  }

  enum rarity: {
    common:      1,
    uncommon:    2,
    rare:        3,
    mythic:      4,
    timeshifted: 5
  }

  enum alternative_type: {
    no_double:   0,
    recto_verso: 1,
    double_card: 2,
    flip_card:   3,
    adventure:   4,
    two_part:    5, # ex Big furry monster
    partenair:   6 # ex Battlebond edition
  }

  belongs_to :extension_set

  has_one :alternative
  has_one :alternative_card, through: :alternative

  has_many :alternate_frames
  has_many :reprints, foreign_key: :card_id, dependent: :destroy
  has_many :reprint_cards, through: :reprints

  before_create :set_colors, :clean_names
  before_save   :set_colors, :set_type
  before_save   :rename, if: proc { |card| card.has_alternative? && !card.name.include?('/') }

  mount_uploader :image, CardImageUploader

  validates_uniqueness_of :gatherer_id, unless: proc { |c| c.has_alternative? || c.is_alternative? }

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

  def is_alternative?
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

  def clean_names
    self[:name_clean] = I18n.transliterate(name || '').downcase.parameterize
  end

  private

  def set_colors
    c_ids = []
    if color_indicator.present?
      color_indicator.downcase.split(',').each do |color|
        c_ids << Color.__send__(color.gsub(' ', ''))
      end
    else
      Color::MANA_COST_MAPPING.each do |mana_c, colors|
        next unless mana_cost&.include?(mana_c.to_s)

        Array.wrap(colors).each do |color|
          c_ids << Color.__send__(color)
        end
      end
    end
    self['color_ids'] = c_ids.any? ? c_ids.uniq.sort : nil
  end

  def set_type
    # TODO
    # TODO
    self.card_type = :other
    self.card_type = :creature_artifact if detailed_type&.include?('Artifact Creature')
    self.card_type = :artifact          if detailed_type&.include?('Artifact')
    self.card_type = :land              if detailed_type&.include?('Land') || basic_land?
    self.card_type = :creature          if detailed_type&.include?('Creature')
  end

  def rename
    self[:name]       = "#{name} / #{alternative.alternative_card.name}"
    self[:name_clean] = name.parameterize
  end
end
