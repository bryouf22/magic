class RemoveCardIdsFromWishlistAndCardCollection < ActiveRecord::Migration[5.2]
  def change
    remove_column :wishlists, :card_ids
    remove_column :card_collections, :card_ids
  end
end
