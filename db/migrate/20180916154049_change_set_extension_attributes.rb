class ChangeSetExtensionAttributes < ActiveRecord::Migration[5.2]
  def change
    rename_column :extension_sets, :logo, :set_visual
    add_column    :extension_sets, :commun_logo, :string
    add_column    :extension_sets, :uncommun_logo, :string
    add_column    :extension_sets, :rare_logo, :string
    add_column    :extension_sets, :mythic_logo, :string
  end
end
