class AddMissingForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :cards, :extension_sets
    add_foreign_key :json_cards, :json_sets
    rename_table :card_data, :card_datas
    rename_table :set_data, :set_datas
    add_foreign_key :card_datas, :set_datas
  end
end
