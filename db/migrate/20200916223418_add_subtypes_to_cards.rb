class AddSubtypesToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :subtypes, :string
  end
end
