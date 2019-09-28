# == Schema Information
#
# Table name: card_decks
#
#  id                      :bigint           not null, primary key
#  card_id                 :bigint
#  deck_id                 :bigint
#  occurences_in_main_deck :integer
#  occurences_in_sideboard :integer
#

class CardDeck < ApplicationRecord
  belongs_to :card
  belongs_to :deck

  scope :main_deck, -> { where('occurences_in_main_deck > 0') }
  scope :sideboard, -> { where('occurences_in_sideboard > 0') }

  validates :card_id, uniqueness: { scope: :deck_id, message: 'already in deck (update occurences_in_main_deck / occurences_in_sideboard' }
end
