class AddCategoryToDeck < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.string :name
      t.timestamps
    end
    add_column :decks, :category_id, :integer
  end
end
