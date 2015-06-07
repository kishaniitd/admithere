class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :locality, :string
    add_column :users, :pincode, :integer
  end
end
