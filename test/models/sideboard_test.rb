# == Schema Information
#
# Table name: sideboards
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_ids   :integer
#  deck_id    :integer
#

require 'test_helper'

class SideboardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
