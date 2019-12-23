class RemoveOrderAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_column :extension_sets, :order
    remove_column :blocs, :bloc_order
  end
end
