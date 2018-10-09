class AddUserIdToDeckWishlistAndCardCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :decks,            :user_id, :integer
    add_column :wishlists,        :user_id, :integer
    add_column :card_collections, :user_id, :integer
  end
end
