class AddSlugToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :slug, :string
  end
end
