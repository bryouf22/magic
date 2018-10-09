# == Schema Information
#
# Table name: wishlists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer
#  user_id    :integer
#  string     :name
#

class Wishlist < ApplicationRecord

  # validate user_id presence true
  # uniqueness name scope user id

  belongs_to :user
end
