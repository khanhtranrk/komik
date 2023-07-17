class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :comic, null: false, foreign_key: true
    end

    add_index :favorites, [:user_id, :comic_id], unique: true
  end
end
