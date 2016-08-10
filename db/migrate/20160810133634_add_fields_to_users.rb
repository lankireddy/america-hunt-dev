class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address_1, :string
    add_column :users, :city, :string
    add_column :users, :zip, :string
    add_column :users, :state, :string
    add_column :users, :lat, :decimal
    add_column :users, :long, :decimal
    add_column :users, :phone, :string
  end
end
