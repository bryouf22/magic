class CreateCardDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :card_decks do |t|
      t.belongs_to :card
      t.belongs_to :deck
      t.integer :occurences_in_main_deck
      t.integer :occurences_in_sideboard
    end
  end
end
