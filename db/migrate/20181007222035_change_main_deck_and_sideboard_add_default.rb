class ChangeMainDeckAndSideboardAddDefault < ActiveRecord::Migration[5.2]
  def up
    add_column :main_decks, :card_ids, :integer, array: true, default: []
    add_column :sideboards, :card_ids, :integer, array: true, default: []
  end

  def down
    remove_column :main_decks, :card_ids
    remove_column :sideboards, :card_ids
  end
end
