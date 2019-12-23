class RemoveUnusedAttributesToCard < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :power
    remove_column :cards, :defense
    remove_column :cards, :name_fr
    remove_column :cards, :image_fr
    remove_column :cards, :type_fr
    remove_column :cards, :text_fr
    remove_column :cards, :flavor_text_fr
  end
end
