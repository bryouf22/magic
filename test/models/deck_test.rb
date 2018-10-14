# == Schema Information
#
# Table name: decks
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  colors     :integer          is an Array
#  format_ids :integer          is an Array
#  user_id    :integer
#  status     :integer          default("personal"), not null
#

require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
