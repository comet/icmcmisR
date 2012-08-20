class AddPayableIdToTreatment < ActiveRecord::Migration
  def self.up
    add_column :treatments, :payable_id, :integer
  end

  def self.down
    remove_column :treatments, :payable_id
  end
end
