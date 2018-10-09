class AddIndexOnCards < ActiveRecord::Migration[5.2]
  def change
    add_index(:cards, :name)
    add_index(:cards, :name_fr)
  end
end
