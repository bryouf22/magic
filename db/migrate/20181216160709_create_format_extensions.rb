class CreateFormatExtensions < ActiveRecord::Migration[5.2]
  def change
    create_table :format_extensions do |t|
      t.belongs_to :format
      t.belongs_to :extension_set
      t.timestamps
    end
  end
end
