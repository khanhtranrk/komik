class UpdateChaptersChangePostedAtColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :chapters, :posted_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
