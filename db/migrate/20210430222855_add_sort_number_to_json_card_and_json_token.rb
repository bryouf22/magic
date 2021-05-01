class AddSortNumberToJsonCardAndJsonToken < ActiveRecord::Migration[5.2]
  def change
    add_column :json_cards, :sort_number, :integer
    add_column :json_tokens, :sort_number, :integer
    JsonCard.all.find_each do |card|
      card.update(sort_number: card.number.to_i) if card.number.to_i.positive?
    end
    JsonToken.all.find_each do |token|
      token.update(sort_number: token.number.to_i) if token.number.to_i.positive?
    end
  end
end
