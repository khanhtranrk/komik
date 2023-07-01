class CreateAuthorsComics < ActiveRecord::Migration[7.0]
  def change
    create_table :authors_comics do |t|
      t.belongs_to :comic, null: false, foreign_key: true
      t.belongs_to :author, null: false, foreign_key: true
    end

    add_index :authors_comics, %i[comic_id author_id], unique: true
  end
end
