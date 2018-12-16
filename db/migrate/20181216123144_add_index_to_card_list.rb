class AddIndexToCardList < ActiveRecord::Migration[5.2]
  def change
    add_index :card_lists, [:card_listable_type, :card_listable_id]
  end
end
