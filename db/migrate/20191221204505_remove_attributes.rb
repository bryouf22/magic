class RemoveAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_column :extension_sets, :bad_visual
  end
end
