class AddFrameTypeToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :frame_type, :integer
    Card.all.update(frame_type: 0)
    change_column :cards, :frame_type, :integer, default: 0, null: false
    add_column :cards, :specific_frame_type, :string
  end
end
