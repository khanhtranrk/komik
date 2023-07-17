class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :firstname, default: ''
      t.string :lastname, default: ''
      t.date :birthday, null: false
      t.integer :role, default: 0
      t.boolean :locked, default: false

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
