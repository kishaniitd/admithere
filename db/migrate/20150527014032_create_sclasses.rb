class CreateSclasses < ActiveRecord::Migration
  def change
    create_table :sclasses do |t|
      t.string :sclassname

      t.timestamps null: false
    end
  end
end
