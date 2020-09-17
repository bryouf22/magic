class RenameCardDetailedType < ActiveRecord::Migration[5.2]
  def change
    Card.find(11664).&update(detailed_type: 'Creature — Elemental')
    Card.other.map(&:set_type!)
  end
end
