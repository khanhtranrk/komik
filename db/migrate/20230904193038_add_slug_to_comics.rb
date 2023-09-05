class AddSlugToComics < ActiveRecord::Migration[7.0]
  def change
    add_column :comics, :slug, :string
  end
end
