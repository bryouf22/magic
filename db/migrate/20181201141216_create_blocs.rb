class CreateBlocs < ActiveRecord::Migration[5.2]
  def change
    create_table :blocs do |t|
      t.integer :bloc_order
      t.timestamps
    end
  end
end
