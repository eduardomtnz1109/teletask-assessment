class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :phone_verified, :boolean, default: false
  end
end
