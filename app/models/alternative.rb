# frozen_string_literal: true

# == Schema Information
#
# Table name: alternatives
#
#  id                  :bigint           not null, primary key
#  card_id             :integer
#  alternative_card_id :integer
#  alternative_type    :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Alternative < ApplicationRecord

  EXCEPTIONS_MAPPING = {
    'Fire / Ice' => 'double_card',
    'Nezumi Graverobber / Nighteyes the Desecrator' => 'flip_card'
  }

  EXTENSION_SET_MAPPING = {
    'Saviors of Kamigawa' => 'flip_card',
    'Hour of Devastation' => 'double_card',
    'Betrayers of Kamigawa' => 'flip_card',
    'Champions of Kamigawa' => 'flip_card',
    'Archenemy' => 'double_card',
    'Planar Chaos' => 'double_card',
    'Magic Origins' => 'recto_verso',
    'Ixalan' => 'recto_verso',
    'Innistrad' => 'recto_verso',
    'Eldritch Moon' => 'recto_verso',
    "Dragon's Maze" => 'double_card',
    'Dissension' => 'double_card',
    'Dark Ascension' => 'recto_verso',
    'Commander 2018' => 'flip_card',
    'Commander 2016' => 'double_card',
    'Amonkhet' => 'double_card',
    'From the Vault: Transform' => 'recto_verso',
    'Duel Decks: Izzet vs. Golgari' => 'double_card',
    'Duel Decks: Ajani vs. Nicol Bolas' => 'double_card',
    'Core Set 2019' => 'recto_verso',
    'Commander Anthology 2018' => 'flip_card',
    'Unglued' => 'two_part',
    'Commander 2013 Edition' => 'double_card',
    'Guilds of Ravnica' => 'double_card',
    'Shadows over Innistrad' => 'recto_verso',
    'Rivals of Ixalan' => 'recto_verso',
    'Guild Kit: Izzet' => 'double_card',
    'Planechase' => 'double_card',
    'Battlebond' => 'partenair',
    'Ultimate Masters' => 'double_card',
    'Time Spiral "Timeshifted"' => 'double_card',
    'Invasion' => 'double_card',
    'Apocalypse' => 'double_card',
    'Ravnica Allegiance' => 'double_card',
    'Throne of Eldraine' => 'adventure'
  }

  belongs_to :card
  belongs_to :alternative_card, class_name: 'Card'

  def self.clean_unvalids
    ids = []
    Alternative.find_each do |alt|
      ids << alt.id if alt.card.nil? && alt.alternative_card.nil?
    end
    Alternative.where(id: ids).destroy_all
  end

  def set_type_to_card!
    return card.update(alternative_type: EXCEPTIONS_MAPPING[card.name]) if EXCEPTIONS_MAPPING[card.name].present?

    card.update(alternative_type: EXTENSION_SET_MAPPING[card.extension_set.name])
  end
end
