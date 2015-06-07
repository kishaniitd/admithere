class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :locality, :state
  end
end
