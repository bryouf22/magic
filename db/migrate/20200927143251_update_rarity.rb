class UpdateRarity < ActiveRecord::Migration[5.2]
  def change
    Card.find(36287).extension_set.cards.each do |card|
      card.update(rarity: :mythic)
    end;nil;
    Card.find(36278).extension_set.cards.each do |card|
      card.update(rarity: :mythic)
    end;nil;
    Card.find(31461).extension_set.cards.each do |card|
      card.update(rarity: :mythic)
    end
  end
end
