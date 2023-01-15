class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :url, null: false
      t.references :imageable, polymorphic: true, null: false, index: true
    end
  end
end
