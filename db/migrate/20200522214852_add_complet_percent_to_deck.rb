class AddCompletPercentToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :complete_percent, :integer
  end
end
