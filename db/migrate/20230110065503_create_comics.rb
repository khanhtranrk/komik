class CreateComics < ActiveRecord::Migration[7.0]
  def change
    create_table :comics do |t|
      t.string :name, null: false
      t.string :other_names, default: ''
      t.string :status, default: ''
      t.integer :views, default: 0
      t.integer :favorites, default: 0
      t.integer :follows, default: 0
      t.text :description, default: ''
      t.datetime :last_updated_chapter_at
      t.datetime :release_date
      t.integer :rating, default: 0
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
