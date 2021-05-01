class Fixnumer < ActiveRecord::Migration[5.2]
  def change
    change_column :json_cards, :number, :string
    JsonCard.where(number: '0').find_each do |card|
      card.update(number: card.json_data['number'])
    end
    JsonCard.all.find_each do |card|
      card.update(sort_number: card.number.to_i) if card.number.to_i.positive?
    end
    JsonToken.all.find_each do |token|
      token.update(sort_number: token.number.to_i) if token.number.to_i.positive?
    end
  end
end
