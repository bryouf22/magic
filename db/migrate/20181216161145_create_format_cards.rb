class CreateFormatCards < ActiveRecord::Migration[5.2]
  def change
    create_table :format_cards do |t|
      t.belongs_to :format
      t.belongs_to :card
      t.boolean :forbidden
      t.timestamps
    end
  end
end
