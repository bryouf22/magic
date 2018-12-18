class AddMainDeckCount < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :card_in_main_deck, :integer
  end
end
