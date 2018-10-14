class AddColorIndactorToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :color_indicator, :string
  end
end
