class AddCardNumberToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :card_number, :integer
  end
end
