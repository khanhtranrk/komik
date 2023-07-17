class CreateReadingChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :reading_chapters do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :comic, null: false, foreign_key: true
      t.belongs_to :chapter, null: false, foreign_key: true
    end

    add_index :reading_chapters, [:user_id, :comic_id], unique: true
  end
end
