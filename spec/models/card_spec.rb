# == Schema Information
#
# Table name: cards
#
#  id               :bigint           not null, primary key
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
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_name      :string
#  number_in_set    :integer
#  gatherer_link    :string
#  gatherer_id      :integer
#  name_clean       :string
#  flavor_text      :text
#  power_str        :string
#  defense_str      :string
#  color_indicator  :string
#  loyalty          :integer
#  format           :integer          default(0), not null
#  first_edition    :boolean
#  is_double_card   :boolean
#  is_double_part   :boolean
#  hybrid           :boolean
#  alternative_type :integer          default("recto_verso")
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
    expect(Card.only_red.count).to                           eq(1)

    Card.create(name: 'Foudre Mentale', mana_cost: 'ru', extension_set_id: ExtensionSet.first.id)

    expect(Card.only_red.count).to         eq(1)
    expect(Card.only_blue.count).to        eq(0)
    expect(Card.gold.count).to             eq(1)
    expect(Card.red.count).to              eq(2)
    expect(Card.blue.count).to             eq(1)

    Card.all.destroy_all

    Card.create(name: 'Intervention divine', mana_cost: 'k', extension_set_id: ExtensionSet.first.id)

    expect(Card.white.count).to             eq(1)
    expect(Card.red.count).to               eq(1)
    expect(Card.gold.count).to              eq(1)
    expect(Card.only_white.count).to        eq(0)
    expect(Card.only_red.count).to          eq(0)
  end
end
