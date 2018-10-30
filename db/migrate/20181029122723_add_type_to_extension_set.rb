class AddTypeToExtensionSet < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :set_type, :integer
  end
end
