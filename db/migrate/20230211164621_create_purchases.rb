class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :plan, null: false, foreign_key: true
      t.float :price, null: false
      t.datetime :effective_at
      t.datetime :expires_at
      t.string :payment_method, null: false

      t.timestamps
    end
  end
end
