class AddAdditionalsAttributesToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :image_fr, :string
    add_column :cards, :type_fr, :string
    add_column :cards, :text_fr, :text
    add_column :cards, :flavor_text, :text
    add_column :cards, :flavor_text_fr, :text

    add_column :cards, :power_str, :string
    add_column :cards, :defense_str, :string
  end
end
