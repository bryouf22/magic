class CreateCardLists < ActiveRecord::Migration[5.2]
  def change
    create_table :card_lists do |t|
      t.belongs_to :card
      t.integer :card_listable_id
      t.string  :card_listable_type
      t.string  :number
      t.string  :foils_number
    end
  end
end
