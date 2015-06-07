class AddTotalfeeToAdmissions < ActiveRecord::Migration
  def change
    add_column :admissions, :totalfee, :integer
  end
end
