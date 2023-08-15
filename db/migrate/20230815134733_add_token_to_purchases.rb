class AddTokenToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :token, :string, null: false, default: ''
  end
end
