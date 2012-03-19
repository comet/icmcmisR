class AddColumnEncounterIdToTreatment < ActiveRecord::Migration
  def self.up
    add_column :treatments, :encounter_id, :integer
  end

  def self.down
    remove_column :treatments, :encounter_id
  end
end
