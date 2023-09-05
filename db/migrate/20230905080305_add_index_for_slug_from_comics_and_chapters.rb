class AddIndexForSlugFromComicsAndChapters < ActiveRecord::Migration[7.0]
  def change
    add_index :comics, :slug, unique: true
    add_index :chapters, :slug, unique: true
  end
end
