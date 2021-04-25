class CreateCardDatasForeignNames < ActiveRecord::Migration[5.2]
  def change
    create_table :card_datas_foreign_names do |t|
      t.integer :card_data_id
      t.string :name
      t.string :text
      t.string :type
      t.string :flavor
      t.string :image_url
      t.string :language
      t.integer :multiverseid
      t.string :faceName
      t.timestamps
    end
  end
end
