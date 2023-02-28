class CreateVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :verifications do |t|
      t.string :code, null: false
      t.datetime :expire_at, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end

    add_index :verifications, :user_id, unique: true
  end
end
