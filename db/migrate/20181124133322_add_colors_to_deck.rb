class AddColorsToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :color_ids, :integer, array: true
  end
end
