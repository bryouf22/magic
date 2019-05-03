# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord

  belongs_to :user

  has_many :decks

  validates :name, uniqueness: { scope: :user_id, message: "Vous possèdez déjà une catégorie avec ce nom !" }
end
