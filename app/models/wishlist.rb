# == Schema Information
#
# Table name: wishlists
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer          is an Array
#  user_id    :integer
#  name       :string
#

class Wishlist < ApplicationRecord
  include CardList

  # TODO : validate user_id presence true
  # TODO : uniqueness name scope user id

  belongs_to :user

end
