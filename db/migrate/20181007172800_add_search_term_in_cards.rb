class AddSearchTermInCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :name_clean, :string
    add_column :cards, :name_fr_clean, :string
    Card.find_each do |card|
      card.update_attributes(name_fr_clean: I18n.transliterate(card.name_fr || '').downcase, name_clean: I18n.transliterate(card.name || '').downcase)
    end
  end
end
