class AddSchooltypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :schooltype, :string
  end
end
