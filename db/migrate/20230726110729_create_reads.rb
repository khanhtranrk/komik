class CreateReads < ActiveRecord::Migration[7.0]
  def change
    create_table :readings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :chapter, null: false, foreign_key: true

      t.timestamps
    end

    add_index :readings, %i[user_id chapter_id], unique: true
  end
end
