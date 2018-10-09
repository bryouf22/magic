# == Schema Information
#
# Table name: card_collections
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer
#  user_id    :integer
#

require 'test_helper'

class CardCollectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
