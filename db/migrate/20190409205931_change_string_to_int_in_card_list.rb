class ChangeStringToIntInCardList < ActiveRecord::Migration[5.2]
  def change

    add_column :card_lists, :number2, :integer
    add_column :card_lists, :foils_number2, :integer

    CardList.find_each do |card_list|
      card_list.update(number2: card_list.number.to_i, foils_number2: card_list.foils_number.to_i)
    end

    remove_column :card_lists, :number
    remove_column :card_lists, :foils_number

    rename_column :card_lists, :number2, :number
    rename_column :card_lists, :foils_number2, :foils_number

  end
end
