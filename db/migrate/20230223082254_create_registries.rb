class CreateRegistries < ActiveRecord::Migration[7.0]
  def change
    create_table :registries do |t|
      t.string :key, null: false
      t.jsonb :value, null: false
    end
    add_index :registries, :key, unique: true
  end
end
