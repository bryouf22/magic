class CreateAlternatives < ActiveRecord::Migration[5.2]
  def change
    create_table :alternatives do |t|
      t.integer :card_id
      t.integer :alternative_card_id
      t.integer :alternative_type
      t.timestamps
    end
  end
end
