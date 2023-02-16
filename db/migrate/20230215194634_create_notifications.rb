class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.bigint :user_id, null: false
      t.jsonb :message, null: false
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
