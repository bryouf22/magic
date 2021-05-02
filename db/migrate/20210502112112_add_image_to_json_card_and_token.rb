class AddImageToJsonCardAndToken < ActiveRecord::Migration[5.2]
  def change
    add_column :json_cards, :image, :string
    add_column :json_tokens, :image, :string
  end
end
