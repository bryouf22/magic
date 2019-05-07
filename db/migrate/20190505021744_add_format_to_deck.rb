class AddFormatToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :format, :integer, default: 0, null: false
  end
end
