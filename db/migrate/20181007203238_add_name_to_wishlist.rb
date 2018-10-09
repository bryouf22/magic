class AddNameToWishlist < ActiveRecord::Migration[5.2]
  def change
    add_column :wishlists, :string, :name
  end
end
