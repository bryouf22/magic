class Deck::RemoveCard
  include Interactor

  def call
    deck        = Deck.find(context.deck_id)
    card_deck   = CardDeck.find(deck.card_decks.where(card_id: context.card_id).first.id)
    remove_from = context.from&.to_sym || :main_deck

    occurences_in_sideboard = card_deck.occurences_in_sideboard

    if remove_from == :main_deck
      occurences_in_main_deck = card_deck.occurences_in_main_deck
      if occurences_in_main_deck == 1 && !occurences_in_sideboard&.positive?
        card_deck.destroy
      else
        card_deck.update_attributes(occurences_in_main_deck: (occurences_in_main_deck - 1))
      end
    elsif occurences_in_sideboard == 1 && !occurences_in_main_deck&.positive?
      card_deck.destroy
    else
      card_deck.update_attributes(occurences_in_sideboard: (occurences_in_sideboard - 1))
    end
    deck.save
  end
end
