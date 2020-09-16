class AddSpecificTypesToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :legend, :boolean
    add_column :cards, :snow, :boolean
    add_column :cards, :tribal, :boolean

    Card.update_all(legend: false, snow: false, tribal: false)

    change_column :cards, :legend, :boolean, default: false
    change_column :cards, :snow, :boolean, default: false
    change_column :cards, :tribal, :boolean, default: false
  end
end
