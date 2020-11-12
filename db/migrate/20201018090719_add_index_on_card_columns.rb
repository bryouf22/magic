class AddIndexOnCardColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :cards, :extension_set_id
    add_index :cards, :card_type
    add_index :cards, :detailed_type
    add_index :cards, :text
    add_index :cards, :cmc
    add_index :cards, :mana_cost
    add_index :cards, :name_clean
    add_index :cards, :subtypes
  end
end
