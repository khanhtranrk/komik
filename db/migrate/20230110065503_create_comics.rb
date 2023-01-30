class CreateComics < ActiveRecord::Migration[7.0]
  def change
    create_table :comics do |t|
      t.string :image
      t.string :name, null: false
      t.string :other_names, default: ''
      t.string :author, default: ''
      t.string :status, default: ''
      t.integer :views, default: 0
      t.integer :likes, default: 0
      t.text :description, default: ''

      t.timestamps
    end
  end
end
