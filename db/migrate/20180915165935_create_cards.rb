class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name_fr
      t.string :name
      t.integer :extension_set_id
      t.integer :type
      t.string :detailed_type
      t.integer :rarity
      t.text :text
      t.integer :cmc
      t.string :mana_cost
      t.integer :color_ids, array: true
      t.string :image
      t.integer :power
      t.integer :defense
      t.timestamps
    end
  end
end
