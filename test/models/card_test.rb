# == Schema Information
#
# Table name: cards
#
#  id               :integer          not null, primary key
#  name_fr          :string
#  name             :string
#  extension_set_id :integer
#  type             :integer
#  detailed_type    :string
#  rarity           :integer
#  text             :text
#  cmc              :integer
#  mana_cost        :string
#  color_ids        :integer
#  image            :string
#  power            :integer
#  defense          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_name      :string
#  number_in_set    :integer
#  gatherer_link    :string
#  gatherer_id      :integer
#  name_clean       :string
#  name_fr_clean    :string
#

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
