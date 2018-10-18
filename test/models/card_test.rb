# == Schema Information
#
# Table name: cards
#
#  id               :bigint(8)        not null, primary key
#  name_fr          :string
#  name             :string
#  extension_set_id :integer
#  type             :integer
#  detailed_type    :string
#  rarity           :integer
#  text             :text
#  cmc              :integer
#  mana_cost        :string
#  color_ids        :integer          is an Array
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
#  image_fr         :string
#  type_fr          :string
#  text_fr          :text
#  flavor_text      :text
#  flavor_text_fr   :text
#  power_str        :string
#  defense_str      :string
#  color_indicator  :string
#  loyalty          :integer
#  reverse_image    :string
#  reverse_image_fr :string
#  reprint_card_ids :integer          default([]), is an Array
#

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
