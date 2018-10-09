# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  colors     :integer
#  format_ids :integer
#  user_id    :integer
#  status     :integer          default("personal"), not null
#

require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
