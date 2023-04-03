class AddLastUpdatedChapterAtToComics < ActiveRecord::Migration[7.0]
  def change
    add_column :comics, :last_updated_chapter_at, :datetime
  end
end
