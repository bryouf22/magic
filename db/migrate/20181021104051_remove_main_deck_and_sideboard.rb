class RemoveMainDeckAndSideboard < ActiveRecord::Migration[5.2]
  def up
    drop_table :main_decks, if_exists: true
    drop_table :sideboards, if_exists: true
  end

  def down
  end
end
