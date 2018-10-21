class CreateReprint < ActiveRecord::Migration[5.2]
  def change
    create_table :reprints do |t|
      t.belongs_to :card, index: true
      t.belongs_to :reprint_card, index: true
    end
  end
end
