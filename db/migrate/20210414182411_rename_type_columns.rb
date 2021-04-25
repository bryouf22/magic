class RenameTypeColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :card_data, :type, :card_type
    rename_column :card_datas_foreign_names, :type, :foreign_name_type
    rename_column :card_datas_foreign_names, :faceName, :face_name
  end
end
