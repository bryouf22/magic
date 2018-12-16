class AddBadVisualToExtensionSet < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :bad_visual, :boolean
  end
end
