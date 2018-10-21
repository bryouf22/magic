# == Schema Information
#
# Table name: cards
#
#  id               :bigint(8)        not null, primary key
#  name_fr          :string
#  name             :string
#  extension_set_id :integer
#  card_type        :integer
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
#

require 'rails_helper'

RSpec.describe Card, :type => :model do

  before(:all) do
    ExtensionSet.create(name: "Spec Edition 2018")
  end

  it 'should create cards and retrieve them with scopes' do
    Card.create(name: 'Plaine', card_type: :land, extension_set_id: ExtensionSet.first.id)
    Card.create(name: 'Choc',   card_type: :instant, extension_set_id: ExtensionSet.first.id)

    expect(Card.land.count).to      eq(1)
    expect(Card.instant.count).to   eq(1)
    expect(Card.colorless.count).to eq(2)
    expect(Card.instant.count).to   eq(1)
    expect(Card.creature.count).to  eq(0)

    Card.create(name: 'Foudre', mana_cost: 'r', extension_set_id: ExtensionSet.first.id)

    expect(Card.where(name: 'Foudre').first.colors).to  eq(['red'])
    expect(Card.red.count).to                           eq(1)

    Card.create(name: 'Foudre Mentale', mana_cost: 'ru', extension_set_id: ExtensionSet.first.id)

    expect(Card.red.count).to         eq(1)
    expect(Card.blue.count).to        eq(0)
    expect(Card.gold.count).to        eq(1)
    expect(Card.also_red.count).to    eq(2)
    expect(Card.also_blue.count).to   eq(1)

    Card.all.destroy_all

    Card.create(name: 'Intervention divine', mana_cost: 'k', extension_set_id: ExtensionSet.first.id)

    expect(Card.also_white.count).to  eq(1)
    expect(Card.also_red.count).to    eq(1)
    expect(Card.gold.count).to        eq(1)
    expect(Card.white.count).to       eq(0)
    expect(Card.red.count).to         eq(0)
  end
end
