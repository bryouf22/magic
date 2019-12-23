class AddReleaseDateToBloc < ActiveRecord::Migration[5.2]
  def change
    add_column :blocs, :release_date, :datetime
  end
end
