class CreateComicsCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :comics_categories do |t|
      t.bigint :category_id, null: false
      t.bigint :comic_id, null: false

      t.timestamps
    end

    add_index :comics_categories, [:category_id, :comic_id], unique: true
  end
end
