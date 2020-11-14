class AddConfiguredToExtensionSet < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :configured, :boolean, default: false
  end
end
