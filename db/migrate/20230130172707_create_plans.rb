class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.float :price, null: false
      t.integer :value, null: false
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
