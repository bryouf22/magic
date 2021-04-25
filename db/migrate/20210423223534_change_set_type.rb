class ChangeSetType < ActiveRecord::Migration[5.2]
  def change
    rename_column :set_data, :type, :set_type
  end
end
