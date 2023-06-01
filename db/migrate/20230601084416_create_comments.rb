class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.bigint :user_id, null: false
      t.bigint :comic_id, null: false
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :comments, [:user_id, :comic_id], unique: true 
  end
end
