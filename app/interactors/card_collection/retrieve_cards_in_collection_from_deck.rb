class CardCollection::RetrieveCardsInCollectionFromDeck
  include Interactor

  def call
    user = User.find(context.user_id)
    deck = Deck.find(context.deck_id)

    result = {}
    deck.cards.each do |card|
      cards_in_collection = user.card_collection.card_lists.where(card_id: [card.id, card.reprint_cards.ids].flatten)

      result[card.id] = if cards_in_collection.any?
                          cards_in_collection.sum { |c| c.number.to_i + c.foils_number.to_i }
                        else
                          0
                        end
    end
    context.result = result
  end
end
