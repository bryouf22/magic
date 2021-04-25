# == Schema Information
#
# Table name: card_data
#
#  id             :bigint           not null, primary key
#  name           :string
#  mana_cost      :string
#  cmc            :string
#  colors         :string           is an Array
#  color_identity :string           is an Array
#  card_type      :string
#  types          :string           is an Array
#  subtypes       :string           is an Array
#  rarity         :string
#  set            :string
#  set_name       :string
#  text           :string
#  artist         :string
#  number         :string
#  power          :string
#  toughness      :string
#  layout         :string
#  multiverseid   :string
#  image_url      :string
#  variations     :string           is an Array
#  printings      :string           is an Array
#  original_text  :string
#  original_type  :string
#  api_id         :string
#  flavor         :string
#  supertypes     :string           is an Array
#  loyalty        :string
#  hand           :string
#  life           :string
#  watermark      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  set_data_id    :integer
#

class CardData < ApplicationRecord

  has_many :foreign_names, dependent: :destroy, class_name: '::CardDatas::ForeignName'
  has_many :legalities, dependent: :destroy, class_name: '::CardDatas::Legality'
  has_many :rulllings, dependent: :destroy, class_name: '::CardDatas::Rulling'

  validates :api_id, uniqueness: true
end
