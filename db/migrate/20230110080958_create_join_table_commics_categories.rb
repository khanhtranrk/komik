class CreateJoinTableCommicsCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :commics, :categories do |t|
      t.index [:commic_id, :category_id]
    end
  end
end
