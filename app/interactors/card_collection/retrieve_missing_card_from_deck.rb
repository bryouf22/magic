class CardCollection::RetrieveMissingCardFromDeck
  include Interactor

  def call
    deck = Deck.find(context.deck_id)

    resultats = {}

    deck.card_ids.each do |card_id|
      current_user.card_collection.where(id: card_id)
    end
    context.deck_id
    current_user.card_collection
    {

    }
  end
end
