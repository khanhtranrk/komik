class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :resolved, default: false

      t.datetime "created_at", null: false
    end
  end
end
