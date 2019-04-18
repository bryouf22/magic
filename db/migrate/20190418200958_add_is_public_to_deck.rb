class AddIsPublicToDeck < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :is_public ,:boolean, default: false
  end
end
