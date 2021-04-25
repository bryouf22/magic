class CreateSetData < ActiveRecord::Migration[5.2]
  def change
    create_table :set_data do |t|
      t.string :code
      t.string :name
      t.string :type
      t.string :booster, array: true
      t.string :release_date
      t.string :block
      t.boolean :online_only
    end
    add_column :card_data, :set_data_id, :integer
  end
end
