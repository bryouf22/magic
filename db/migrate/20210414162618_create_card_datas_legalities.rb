class CreateCardDatasLegalities < ActiveRecord::Migration[5.2]
  def change
    create_table :card_datas_legalities do |t|
      t.integer :card_data_id
      t.string :format
      t.string :legality
      t.timestamps
    end
  end
end
