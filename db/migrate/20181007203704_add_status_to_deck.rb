class AddStatusToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :status, :integer, default: 1, null: false
  end
end
