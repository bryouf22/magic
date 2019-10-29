class AddSlugToWishlist < ActiveRecord::Migration[5.2]
  def change
    add_column :wishlists, :slug, :string
    Wishlist.all.find_each do |wishlist|
      wishlist.update(slug: wishlist.name.parameterize)
    end
    change_column :wishlists, :slug, :string, null: false
  end
end
