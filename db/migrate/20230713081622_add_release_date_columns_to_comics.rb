class AddReleaseDateColumnsToComics < ActiveRecord::Migration[7.0]
  def change
    add_column :comics, :release_date, :date
  end
end
