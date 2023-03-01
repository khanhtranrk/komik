class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.bigint :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
