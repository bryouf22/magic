class CreateFormats < ActiveRecord::Migration[5.2]
  def change
    create_table :formats do |t|
      t.string :name
      t.integer :card_limit
      t.integer :card_occurence_limit
      t.timestamps
    end
  end
end
