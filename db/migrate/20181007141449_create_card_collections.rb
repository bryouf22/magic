class CreateCardCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :card_collections do |t|

      t.timestamps
      t.integer :card_ids, array: true
    end
  end
end
