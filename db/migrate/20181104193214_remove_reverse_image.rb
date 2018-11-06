class RemoveReverseImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :reverse_image
    remove_column :cards, :reverse_image_fr
  end
end
