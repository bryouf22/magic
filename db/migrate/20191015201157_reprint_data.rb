class ReprintData < ActiveRecord::Migration[5.2]
  def change
    add_column :extension_sets, :card_count, :integer
    add_column :extension_sets, :new_card_count, :integer
    add_column :extension_sets, :reprint_count, :integer

    add_column :cards, :first_edition, :boolean
  end
end
