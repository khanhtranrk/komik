class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :name, null: false
      t.boolean :free, default: false
      t.belongs_to :comic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
