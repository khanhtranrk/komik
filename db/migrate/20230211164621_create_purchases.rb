class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.bigint :user_id, null: false
      t.bigint :plan_id, null: false
      t.float :price, null: false
      t.datetime :effective_date
      t.datetime :expiry_date
      t.string :payment_method, null: false

      t.timestamps
    end
  end
end
