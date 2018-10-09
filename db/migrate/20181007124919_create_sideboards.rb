class CreateSideboards < ActiveRecord::Migration[5.2]
  def change
    create_table :sideboards do |t|

      t.timestamps
    end
  end
end
