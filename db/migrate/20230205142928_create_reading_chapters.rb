class CreateReadingChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :reading_chapters do |t|
      t.bigint :user_id, null: false
      t.bigint :comic_id, null: false
      t.bigint :chapter_id, null: false
    end

    add_index :reading_chapters, [:user_id, :comic_id], unique: true
  end
end
