class AddPatientIdToTreatment < ActiveRecord::Migration
  def self.up
    add_column :treatments, :patient_id, :integer
  end

  def self.down
    remove_column :treatments, :patient_id
  end
end
