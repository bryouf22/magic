class AddSetExtraCardToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :set_extra_card, :boolean
  end
end
