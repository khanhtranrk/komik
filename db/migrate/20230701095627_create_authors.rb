class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.datetime :birthday, null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
