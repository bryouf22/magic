class CardCollection::RetrieveMissingCardFromDeck
  include Interactor

  def call
    user = User.find(context.user_id)
    deck = Deck.find(context.deck_id)

    in_collection = {}
    result        = {}

    deck.cards.each do |card|
      card_and_reprint_ids = [card.id, card.reprint_cards.ids].flatten
      if user.card_collection.card_lists.where(card_id: card_and_reprint_ids).any?
        in_collection[card.id] = user.card_collection.card_lists.where(card_id: card_and_reprint_ids).sum { |c| c.number.to_i + c.foils_number.to_i }
      else
        in_collection[card.id] = 0
      end
    end

    in_collection.each do |card_id, count_in_collection|
      card = Card.find(card_id)
      card_and_reprint_ids = [card.id, card.reprint_cards.ids].flatten
      card_deck = deck.card_decks.find { |cd| cd.card_id.in?(card_and_reprint_ids) }
      occur_in_deck = card_deck.occurences_in_main_deck + card_deck.occurences_in_sideboard
      result[card.name] = occur_in_deck - count_in_collection unless count_in_collection >= occur_in_deck
    end
    context.result = result
  end
end
