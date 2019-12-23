class RemoveAttributesToCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :name_fr_clean
  end
end
