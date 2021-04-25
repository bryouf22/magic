class CreateCardDatasRullings < ActiveRecord::Migration[5.2]
  def change
    create_table :card_datas_rullings do |t|
      t.integer :card_data_id
      t.string :date
      t.string :text
      t.timestamps
    end
  end
end
