class MoveDeckIdToMainDeckAndSideboard < ActiveRecord::Migration[5.2]
  def change
    remove_column :decks, :main_deck_id
    remove_column :decks, :sideboard_id

    add_column :main_decks, :deck_id, :integer
    add_column :sideboards, :deck_id, :integer
  end
end
