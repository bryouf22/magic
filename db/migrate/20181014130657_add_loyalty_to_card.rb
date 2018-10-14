class AddLoyaltyToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :loyalty, :integer
  end
end
