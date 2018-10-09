class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|

      t.timestamps
      t.string :name
      t.integer :colors, array: true
      t.integer :format_ids, array: true
      t.integer :main_deck_id
      t.integer :sideboard_id
    end
  end
end
