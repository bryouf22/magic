# == Schema Information
#
# Table name: card_collections
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class CardCollection < ApplicationRecord
  belongs_to :user
  validates :user, presence: true, uniqueness: true

  has_many :card_lists, as: :card_listable
  has_many :cards, through: :card_lists
end
