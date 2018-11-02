class Deck::AddCard
  include Interactor

  def call
    deck    = Deck.find(context.deck_id)
    card_id = context.card_id
    add_in  = context.in&.to_sym || :main_deck

    if add_in == :main_deck
      if (card_deck = deck.card_decks.where(card_id: card_id).first)
        card_deck.update_attributes(occurences_in_main_deck: (card_deck.occurences_in_main_deck + 1))
      else
        CardDeck.create(deck_id: deck.id, card_id: card_id, occurences_in_main_deck: 1, occurences_in_sideboard: 0)
      end
    else
      if (card_deck = deck.card_decks.where(card_id: card_id).first)
        card_deck.update_attributes(occurences_in_sideboard: (card_deck.occurences_in_sideboard + 1))
      else
        CardDeck.create(deck_id: deck.id, card_id: card_id, occurences_in_main_deck: 0, occurences_in_sideboard: 1)
      end
    end
  end
end
