class AddExtensionCode < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :code, :string
  end
end
