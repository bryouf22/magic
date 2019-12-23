class AddDoubleAndHybridToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :is_double_card, :boolean
    add_column :cards, :is_double_part, :boolean
    add_column :cards, :hybrid, :boolean
    Card.update_all(is_double_card: false, is_double_part: false, hybrid: false)
    change_column :cards, :is_double_card, :boolean, default: false
    change_column :cards, :is_double_part, :boolean, default: false
    change_column :cards, :hybrid, :boolean, default: false
  end
end
