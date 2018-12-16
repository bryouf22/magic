class AddIndexToCardDeck < ActiveRecord::Migration[5.2]
  def change
    add_index :card_decks, [:card_id, :deck_id]
  end
end
