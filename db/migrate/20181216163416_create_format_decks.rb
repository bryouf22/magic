class CreateFormatDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :format_decks do |t|
      t.belongs_to :format
      t.belongs_to :deck
      t.timestamps
    end
  end
end
