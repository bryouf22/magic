# == Schema Information
#
# Table name: extension_sets
#
#  id           :bigint           not null, primary key
#  name         :string
#  release_date :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string
#  set_type     :integer
#  order        :integer
#  bloc_id      :integer
#  set_list_id  :integer
#  bad_visual   :boolean
#  code         :string
#

class ExtensionSet < ApplicationRecord
  has_many :cards
  has_many :gatherer_card_urls

  belongs_to :bloc, optional: true
  belongs_to :set_list, optional: true

  scope :without_visual, -> { where(bad_visual: true) }

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
    commander:      12
  }

  private

  def generate_slug
    self[:slug] = name.parameterize
  end
end
