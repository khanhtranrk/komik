class ChangeBirthdayColumnFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :birthday, :datetime, null: false
  end
end
