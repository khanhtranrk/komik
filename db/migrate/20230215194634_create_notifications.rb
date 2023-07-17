class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.jsonb :message, null: false
      t.boolean :seen, default: false

      t.datetime "created_at", null: false
    end
  end
end
