# == Schema Information
#
# Table name: cards
#
#  id               :bigint(8)        not null, primary key
#  name_fr          :string
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
#  power            :integer
#  defense          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_name      :string
#  number_in_set    :integer
#  gatherer_link    :string
#  gatherer_id      :integer
#  name_clean       :string
#  name_fr_clean    :string
#  image_fr         :string
#  type_fr          :string
#  text_fr          :text
#  flavor_text      :text
#  flavor_text_fr   :text
#  power_str        :string
#  defense_str      :string
#  color_indicator  :string
#  loyalty          :integer
#  reverse_image    :string
#  reverse_image_fr :string
#

class Card < ApplicationRecord

  # TODO : ajouter bitfield pour le format (https://github.com/grosser/bitfields)

  # https://edgeguides.rubyonrails.org/active_record_postgresql.html#array
  # TODO : scope also_white
  # TODO : scope also_red etc
  scope :only_green,       -> { where(color_ids: [Color.green]) }
  scope :only_red,         -> { where(color_ids: [Color.red])   }
  scope :only_blue,        -> { where(color_ids: [Color.blue])  }
  scope :only_white,       -> { where(color_ids: [Color.white]) }
  scope :only_black,       -> { where(color_ids: [Color.black]) }
  scope :gold,             -> { where("array_length(color_ids, 1) >= 2") }
  scope :colorless,        -> { where('color_ids is ?', nil) }
  scope :red,              -> { where("? = ANY(color_ids)", Color.red)}
  scope :blue,             -> { where("? = ANY(color_ids)", Color.blue)}
  scope :black,            -> { where("? = ANY(color_ids)", Color.black)}
  scope :green,            -> { where("? = ANY(color_ids)", Color.green)}
  scope :white,            -> { where("? = ANY(color_ids)", Color.white)}

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
    other:              10,
  }

  enum rarity: {
    common:   1,
    uncommun: 2,
    rare:     3,
    mythic:   4
  }

  belongs_to :extension_set

  has_many :reprints, foreign_key: :card_id
  has_many :reprint_cards, through: :reprints

  before_create :set_colors, :clean_names

  mount_uploader :image,            CardImageUploader
  mount_uploader :reverse_image,    CardImageUploader
  mount_uploader :image_fr,         CardImageUploader
  mount_uploader :reverse_image_fr, CardImageUploader

  def icone_url
    case rarity
    when 'commun'
      extension_set.commun_logo&.url
    when 'uncommun'
      extension_set.uncommun_logo&.url
    when 'rare'
      extension_set.rare_logo&.url
    when 'mythic'
      extension_set.mythic_logo&.url
    else
      extension_set.commun_logo&.url
    end
  end

  def colorless?
    !color_ids.present?
  end

  def colors
    return nil unless color_ids.any?
    colors = []
    color_ids.each do |id|
      colors << Color::COLORS_MAPPING.invert[id].to_s
    end
    colors
  end

  # TODO : faire un belongs_to card pour les cartes doubles, les cartes a inversion, et les cartes recto verso (www.magic-ville.com/fr/carte?ref=chk002)
  # (on ne gère pas recto verso de la meme facon, c'est géré via reverse image)

  private

  def set_colors
    c_ids = []
    Color::MANA_COST_MAPPING.each do |mana_c, colors|
      if mana_cost&.include?(mana_c.to_s)
        Array.wrap(colors).each do |color|
          c_ids << Color.__send__(color)
        end
      end
    end
    self['color_ids'] = c_ids.any? ? c_ids.uniq : nil
  end

  def clean_names
    self[:name_fr_clean] = I18n.transliterate(name_fr || '').downcase
    self[:name_clean]    = I18n.transliterate(name || '').downcase
  end
end
