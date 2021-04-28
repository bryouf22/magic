class CreateJsonSet < ActiveRecord::Migration[5.2]
  def change
    create_table :json_sets do |t|
      t.string :code
      t.string :name
      t.json :json_data
    end
  end
end
