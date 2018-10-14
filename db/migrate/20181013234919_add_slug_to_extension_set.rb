class AddSlugToExtensionSet < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :slug, :string
  end
end
