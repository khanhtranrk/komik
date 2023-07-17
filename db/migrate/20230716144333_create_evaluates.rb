class CreateEvaluates < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluates do |t|
      t.integer :point_of_view
      t.belongs_to :review, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
    end

    add_index :evaluates, [:review_id, :user_id], unique: true
  end
end
