class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
      t.date :startdate
      t.date :enddate
      t.references :user, index: true
      t.references :sclass, index: true
      t.references :subject, index: true

      t.timestamps null: false
    end
    add_foreign_key :admissions, :users
    add_foreign_key :admissions, :sclasses
    add_foreign_key :admissions, :subjects
  end
end
