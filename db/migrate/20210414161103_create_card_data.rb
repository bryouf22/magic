class CreateCardData < ActiveRecord::Migration[5.2]
  def change
    create_table :card_data do |t|
      t.string :name
      t.string :mana_cost
      t.string :cmc
      t.string :colors, array: true
      t.string :color_identity, array: true
      t.string :type
      t.string :types, array: true
      t.string :subtypes, array: true
      t.string :rarity
      t.string :set
      t.string :set_name
      t.string :text
      t.string :artist
      t.string :number
      t.string :power
      t.string :toughness
      t.string :layout
      t.string :multiverseid
      t.string :image_url
      t.string :variations, array: true
      t.string :printings, array: true
      t.string :original_text
      t.string :original_type
      t.string :api_id
      t.string :flavor
      t.string :supertypes, array: true
      t.string :loyalty
      t.string :hand
      t.string :life
      t.string :watermark

      t.timestamps
    end
  end
end
