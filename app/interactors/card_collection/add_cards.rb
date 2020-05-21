class CardCollection::AddCards
  include Interactor

  def call
    card_collection = CardCollection.find(context.card_collection_id)
    card_ids = Array.wrap(context.card_id || context.card_ids)
    count = context.count.presence || 1

    card_ids.each do |card_id|
      if (card_list = CardList.where(card_id: card_id, card_listable_type: 'CardCollection', card_listable_id: card_collection.id).first)
        card_list.update(number: card_list.number.to_i + count.to_i)
      else
        CardList.create(card_id: card_id, card_listable_type: 'CardCollection', card_listable_id: card_collection.id, number: count)
      end
    end
  end
end
