class AddSlugToChapters < ActiveRecord::Migration[7.0]
  def change
    add_column :chapters, :slug, :string
  end
end
