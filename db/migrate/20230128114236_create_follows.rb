class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.bigint :user_id, null: false
      t.bigint :comic_id, null: false
    end

    add_index :follows, [:user_id, :comic_id], unique: true
  end
end
