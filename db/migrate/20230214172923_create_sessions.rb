class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :refresh_token, null: false
      t.string :access_token, null: false
      t.datetime :expire_at, null: false

      t.timestamps
    end

    add_index :sessions, [:user_id, :refresh_token], unique: true
  end
end
