class SetHybrids < ActiveRecord::Migration[5.2]
  def change
    Card.all.map(&:reset_hybrid!)
  end
end
