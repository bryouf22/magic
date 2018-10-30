class CreateGathererCardUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :gatherer_card_urls do |t|
      t.string :url
      t.integer :extension_set_id
      t.timestamps
    end
  end
end
