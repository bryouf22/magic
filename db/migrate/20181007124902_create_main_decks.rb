class CreateMainDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :main_decks do |t|

      t.timestamps
    end
  end
end
