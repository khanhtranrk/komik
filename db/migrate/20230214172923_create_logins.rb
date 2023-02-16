class CreateLogins < ActiveRecord::Migration[7.0]
  def change
    create_table :logins do |t|
      t.bigint :user_id, null: false
      t.string :token, null: false
      t.string :access_token, null: false
      t.datetime :expire_at, null: false

      t.timestamps
    end

    add_index :logins, [:user_id, :token], unique: true
  end
end
