class CreateSetLists < ActiveRecord::Migration[5.2]
  def change
    create_table :set_lists do |t|
      t.string :name
      t.timestamps
    end
  end
end
