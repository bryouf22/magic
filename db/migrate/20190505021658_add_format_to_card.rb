class AddFormatToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :format, :integer, default: 0, null: false
  end
end
