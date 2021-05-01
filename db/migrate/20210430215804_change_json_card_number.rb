class ChangeJsonCardNumber < ActiveRecord::Migration[5.2]
  def change
    change_column :json_cards, :number, :string
    JsonCard.where(number: '0').find_each do |card|
      card.update(number: card.json_data['number'])
    end
    # add_column :json_tokens, :number, :string
    # JsonToken.all.find_each do |token|
    #   token.update(number: token.json_data['number'])
    # end
  end
end
