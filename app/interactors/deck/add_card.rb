class Deck::AddCard
  include Interactor

  def call
    deck    = Deck.find(context.deck_id)
    card_id = context.card_id
    add_in  = context.in&.to_sym || :main_deck

    card_ids = [card_id, Card.find(card_id).reprints.collect(&:reprint_card_id)].flatten.uniq
    if add_in == :main_deck
      if (card_deck = deck.card_decks.where(card_id: card_ids).first)
        card_deck.update_attributes(occurences_in_main_deck: (card_deck.occurences_in_main_deck + 1))
      else
        CardDeck.create(deck_id: deck.id, card_id: card_id, occurences_in_main_deck: 1, occurences_in_sideboard: 0)
      end
    elsif (card_deck = deck.card_decks.where(card_id: card_ids).first)
      card_deck.update_attributes(occurences_in_sideboard: (card_deck.occurences_in_sideboard + 1))
    else
      CardDeck.create(deck_id: deck.id, card_id: card_id, occurences_in_main_deck: 0, occurences_in_sideboard: 1)
    end
    deck.save
  end
end
