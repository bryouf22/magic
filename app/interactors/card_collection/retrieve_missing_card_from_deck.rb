class CardCollection::RetrieveMissingCardFromDeck
  include Interactor

  def call
    user = User.find(context.user_id)
    deck = Deck.find(context.deck_id)

    resultat = {}
    deck.card_ids.each do |card_id|
      if(card_list = user.card_collection.card_lists.where(card_id: card_id).first)
        resultat[card_id] = card_list.number + card_list.foils_number
      else
        resultat[card_id] = 0
      end
    end
    context.resultat = resultat
  end
end
