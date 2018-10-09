class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|

      t.timestamps
      t.integer :card_ids, array: true
    end
  end
end
