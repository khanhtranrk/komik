class CreateVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :verifications do |t|
      t.string :code, null: false
      t.datetime :expire_at, null: false
      t.belongs_to :user, null: false, unique: true, foreign_key: true

      t.timestamps
    end
  end
end
