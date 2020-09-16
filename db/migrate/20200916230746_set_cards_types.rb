class SetCardsTypes < ActiveRecord::Migration[5.2]
  def up
    Card.all.map(&:set_type!)
  end
end
