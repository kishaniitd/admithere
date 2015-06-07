class AddAttachmentFeestructureToAdmissions < ActiveRecord::Migration
  def self.up
    change_table :admissions do |t|
      t.attachment :feestructure
    end
  end

  def self.down
    remove_attachment :admissions, :feestructure
  end
end
