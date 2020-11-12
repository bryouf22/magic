# == Schema Information
#
# Table name: wishlists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  name       :string
#  slug       :string           not null
#

class Wishlist < ApplicationRecord
  belongs_to :user

  has_many :card_lists, as: :card_listable
  has_many :cards, through: :card_lists

  before_save :update_slug

  validates :user, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, message: 'User have already a wishlist with this name' }

  private

  def update_slug
    self[:slug] = name.parameterize
  end
end
