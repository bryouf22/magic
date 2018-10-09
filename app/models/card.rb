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


  # ajouter bitfield
  # pour le format
  # voir : https://github.com/grosser/bitfields


  # create colors associations

  belongs_to :extension_set

  mount_uploader :image, CardImageUploader

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
end
