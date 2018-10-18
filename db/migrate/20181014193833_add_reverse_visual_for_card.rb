class AddReverseVisualForCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :reverse_image, :string
    add_column :cards, :reverse_image_fr, :string
  end
end
