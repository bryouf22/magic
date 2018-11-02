class Deck::MoveCard
  include Interactor

  def call
    deck      = Deck.find(context.deck_id)
    card_deck = deck.card_decks.where(card_id: context.card_id).first!
    move_in   = context.move_in&.to_sym || :main_deck

    if move_in == :main_deck
      card_deck.update_attributes(occurences_in_main_deck: (card_deck.occurences_in_main_deck + 1), occurences_in_sideboard: (card_deck.occurences_in_sideboard - 1))
    else
      card_deck.update_attributes(occurences_in_main_deck: (card_deck.occurences_in_main_deck - 1), occurences_in_sideboard: (card_deck.occurences_in_sideboard + 1))
    end
  end
end
