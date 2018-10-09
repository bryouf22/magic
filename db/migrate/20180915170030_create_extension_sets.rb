class CreateExtensionSets < ActiveRecord::Migration[5.2]
  def change
    create_table :extension_sets do |t|
      t.string :name
      t.datetime :release_date
      t.string :logo
      t.timestamps
    end
  end
end
