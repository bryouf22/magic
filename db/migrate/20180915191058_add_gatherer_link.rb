class AddGathererLink < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :gatherer_link, :string
    add_column :cards, :gatherer_id, :integer
  end
end
