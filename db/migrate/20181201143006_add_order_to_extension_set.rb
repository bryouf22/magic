class AddOrderToExtensionSet < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :order, :integer
    add_column :extension_sets, :bloc_id, :integer
    add_column :extension_sets, :set_list_id, :integer
  end
end
