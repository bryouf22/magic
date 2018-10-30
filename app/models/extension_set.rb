# == Schema Information
#
# Table name: extension_sets
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  release_date  :datetime
#  set_visual    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  commun_logo   :string
#  uncommun_logo :string
#  rare_logo     :string
#  mythic_logo   :string
#  slug          :string
#  set_type      :integer
#

class ExtensionSet < ApplicationRecord

  has_many :cards
  has_many :gatherer_card_url

  mount_uploader :set_visual,     CardImageUploader
  mount_uploader :commun_logo,    CardImageUploader
  mount_uploader :uncommun_logo,  CardImageUploader
  mount_uploader :rare_logo,      CardImageUploader
  mount_uploader :mythic_logo,    CardImageUploader

  before_create :generate_slug

  enum set_type: {
    block_set:      1,
    basic_edition:  2,
    from_the_vault: 3,
    dual_deck:      4,
    reedition:      5,
    premium_deck:   6,
    humouristic:    7,
    starter:        8,
    other:          9,
    online:         10,
    masterpiece:    11,
  }

  private

  def generate_slug
    self[:slug] = name.parameterize
  end
end
