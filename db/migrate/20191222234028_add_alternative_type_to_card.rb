class AddAlternativeTypeToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :alternative_type, :integer
    Card.where.not(is_double_card: true).update_all(alternative_type: 0)
    change_column :cards, :alternative_type, :integer, default: 0
  end
end
