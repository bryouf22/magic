class ChangeCardTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :type, :card_type
  end
end
