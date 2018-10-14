class FixWishListName < ActiveRecord::Migration[5.2]
  def change
    remove_column :wishlists, :string
    add_column :wishlists, :name, :string
  end
end
