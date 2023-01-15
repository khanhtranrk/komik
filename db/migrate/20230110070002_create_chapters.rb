class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :name, null: false
      t.datetime :posted_at, default: Time.zone.now
      t.boolean :free, default: false
      t.references :commic, null: false, foreign_key: true
    end
  end
end
