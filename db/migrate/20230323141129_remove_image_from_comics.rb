class RemoveImageFromComics < ActiveRecord::Migration[7.0]
  def change
    remove_column :comics, :image, :string
  end
end
