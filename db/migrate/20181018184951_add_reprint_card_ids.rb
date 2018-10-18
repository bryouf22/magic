class AddReprintCardIds < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :reprint_card_ids, :integer, array: true, default: []
  end
end
