class CardCollection::RetrieveMissingCardFromDeck
  include Interactor

  def call
    user = User.find(context.user_id)
    deck = Deck.find(context.deck_id)

    resultat = {}
    deck.cards.each do |card|
      if user.card_collection.card_lists.where(card_id: [card.id, card.reprint_cards.ids].flatten).any?
        resultat[card.id] = user.card_collection.card_lists.where(card_id: [card.id, card.reprint_cards.ids].flatten).sum { |c| c.number.to_i + c.foils_number.to_i }
      else
        resultat[card.id] = 0
      end
    end
    context.resultat = resultat
  end
end
