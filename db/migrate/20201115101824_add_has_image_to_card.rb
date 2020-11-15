class AddHasImageToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :has_image, :boolean
    Card.all.find_each do |card|
      card.set_has_image!
    end
  end
end
