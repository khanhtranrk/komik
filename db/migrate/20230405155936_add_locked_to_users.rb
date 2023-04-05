class AddLockedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :locked, :boolean, default: true
  end
end
