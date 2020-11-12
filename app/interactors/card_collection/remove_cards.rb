class CardCollection::RemoveCards
  include Interactor

  def call
    card_collection = CardCollection.find(context.card_collection_id)
    card_ids        = Array.wrap(context.card_id || context.card_ids).map(&:to_i)
    count           = (context.count.presence || 1).to_i
    card_list_ids   = []

    card_ids.each do |card_id|
      card_ids   = [Card.find(card_id).reprint_cards.ids, card_id.to_i].flatten
      card_lists = CardList.where(card_id: card_ids, card_listable_type: 'CardCollection', card_listable_id: card_collection.id)

      next unless card_lists.any?

      card_lists.each do |card_list|
        next if count.zero?

        if count > card_list.number.to_i
          card_list.update(number: 0)
          count -= card_list.number.to_i
        elsif card_list.number.to_i.positive?
          card_list.update(number: card_list.number.to_i - count)
          count -= card_list.number.to_i
        end

        if count > card_list.foils_number.to_i
          card_list.update(foils_number: 0)
          count -= card_list.foils_number.to_i
        elsif card_list.foils_number.to_i.positive?
          card_list.update(foils_number: card_list.foils_number.to_i - count)
          count -= card_list.foils_number.to_i
        end

        card_list_ids << [card_list.id] if (card_list.foils_number.to_i + card_list.number.to_i).zero?
      end
    end
    CardList.where(id: card_list_ids).destroy_all
  end
end
