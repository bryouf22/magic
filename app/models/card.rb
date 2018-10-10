# == Schema Information
#
# Table name: cards
#
#  id               :integer          not null, primary key
#  name_fr          :string
#  name             :string
#  extension_set_id :integer
#  type             :integer
#  detailed_type    :string
#  rarity           :integer
#  text             :text
#  cmc              :integer
#  mana_cost        :string
#  color_ids        :integer
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
#

class Card < ApplicationRecord

  # TODO : ajouter bitfield
  # pour le format
  # voir : https://github.com/grosser/bitfields

  MANA_COST_MAPPING = { w: :white, u: :blue, b: :black, r: :red, g: :green }

  scope :green,     -> { color_ids.include?(Color.green) }
  scope :red,       -> { color_ids.include?(Color.red)   }
  scope :blue,      -> { color_ids.include?(Color.blue)  }
  scope :white,     -> { color_ids.include?(Color.white) }
  scope :black,     -> { color_ids.include?(Color.black) }
  scope :colorless, -> { where('color_ids is ?', nil) }


  enum type: {
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

  before_save :set_colors

  mount_uploader :image, CardImageUploader

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

  private

  def set_colors
    c_ids = []
    MANA_COST_MAPPING.each do |mana_c, color|
      c_ids << Color.__send__(color) if mana_cost&.include?(mana_c.to_s)
    end
    self['color_ids'] = c_ids.any? ? c_ids.uniq : nil
  end
end
