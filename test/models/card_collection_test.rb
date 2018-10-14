# == Schema Information
#
# Table name: card_collections
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer          is an Array
#  user_id    :integer
#

require 'test_helper'

class CardCollectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
