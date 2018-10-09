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

require 'test_helper'

class WishlistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
