# == Schema Information
#
# Table name: card_decks
#
#  id                      :bigint(8)        not null, primary key
#  card_id                 :bigint(8)
#  deck_id                 :bigint(8)
#  occurences_in_main_deck :integer
#  occurences_in_sideboard :integer
#

class CardDeck < ApplicationRecord

  belongs_to :card
  belongs_to :deck

  validates :card_id, uniqueness: { scope: :deck_id, message: "already in deck (update occurences_in_main_deck / occurences_in_sideboard" }
end
