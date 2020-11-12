class SetColors < ActiveRecord::Migration[5.2]
  def change
    Card.all.map(&:reset_colors!)
  end
end
