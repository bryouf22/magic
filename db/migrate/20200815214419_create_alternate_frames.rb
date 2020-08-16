class CreateAlternateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :alternate_frames do |t|
      t.integer :card_id, null: false
      t.string :image
      t.timestamps
    end
  end
end
