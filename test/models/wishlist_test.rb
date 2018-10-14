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

require 'test_helper'

class WishlistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
