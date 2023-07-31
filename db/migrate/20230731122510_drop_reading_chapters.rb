class DropReadingChapters < ActiveRecord::Migration[7.0]
  def change
    drop_table :reading_chapters
  end
end
