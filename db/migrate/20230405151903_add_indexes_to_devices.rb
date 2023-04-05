class AddIndexesToDevices < ActiveRecord::Migration[7.0]
  def change
    add_index :devices, :login_id, unique: true
  end
end
