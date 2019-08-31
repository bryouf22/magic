class RemoveExtensionLogo < ActiveRecord::Migration[5.2]
  def change
    remove_column :extension_sets, :commun_logo
    remove_column :extension_sets, :uncommun_logo
    remove_column :extension_sets, :rare_logo
    remove_column :extension_sets, :mythic_logo
    remove_column :extension_sets, :set_visual
  end
end
