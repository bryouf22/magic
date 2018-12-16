class Wishlist::AddCards
  include Interactor

  def call
    wishlist = Wishlist.find(context.wishlist_id)
    card_ids = Array.wrap(context.card_id || context.card_ids)

    card_ids.each do |card_id|
      if (card_list = CardList.where(card_id: card_id, card_listable_type: 'Wishlist', card_listable_id: wishlist.id).first)
        card_list.update(number: card_list.number + 1)
      else
        CardList.create(card_id: card_id, card_listable_type: 'Wishlist', card_listable_id: wishlist.id, number: 1)
      end
    end
  end
end
