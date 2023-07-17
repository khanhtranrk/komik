class CreateComicsCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :comics_categories do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :comic, null: false, foreign_key: true
    end

    add_index :comics_categories, [:category_id, :comic_id], unique: true
  end
end
