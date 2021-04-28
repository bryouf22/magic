class CreateJsonCard < ActiveRecord::Migration[5.2]
  def change
    create_table :json_cards do |t|
      t.integer :json_set_id
      t.string :name
      t.json :json_data
    end
  end
end
