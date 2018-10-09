class AddArtistAndNumberInCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :artist_name, :string
    add_column :cards, :number_in_set, :integer
  end
end
