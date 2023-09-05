class AddPseudonymToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :pseudonym, :string, null: false, default: ''
  end
end
