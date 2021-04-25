class ChangerCardDayaNumber < ActiveRecord::Migration[5.2]
  def change
    rename_column :card_data, :number, :number_tmp
    add_column :card_data, :number, :integer
    CardData.all.find_each do |card|
      card.update(number: card.number_tmp)
    end
  end
end
