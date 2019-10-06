class DropTableFormatDeck < ActiveRecord::Migration[5.2]
  def change
    drop_table(:format_decks, if_exists: true)
  end
end
