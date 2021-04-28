class CreateJsonToken < ActiveRecord::Migration[5.2]
  def change
    create_table :json_tokens do |t|
      t.string :uuid
      t.string :name
      t.integer :json_set_id
      t.json :json_data
    end
    add_foreign_key :json_tokens, :json_sets

    add_column :json_cards, :uuid, :string
  end
end
