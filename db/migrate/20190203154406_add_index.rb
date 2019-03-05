class AddIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :reprints, [:card_id, :reprint_card_id]
  end
end
