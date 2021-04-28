class AddAttrToJsonModels < ActiveRecord::Migration[5.2]
  def change
    add_column :json_sets, :set_type, :string
    add_column :json_sets, :release_date, :string
    add_column :json_sets, :total_set_size, :integer
    add_column :json_cards, :number, :integer

    JsonSet.all.find_each do |set|
      set.set_type = set.json_data['type']
      set.release_date = set.json_data['releaseDate']
      set.total_set_size = set.json_data['totalSetSize']
      set.save
    end

    JsonCard.all.find_each do |card|
      card.number = card.json_data['number']
      card.save
    end
  end
end
