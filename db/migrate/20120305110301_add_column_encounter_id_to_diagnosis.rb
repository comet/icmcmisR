class AddColumnEncounterIdToDiagnosis < ActiveRecord::Migration
  def self.up
    add_column :diagnoses, :encounter_id, :integer
  end

  def self.down
    remove_column :diagnoses, :encounter_id
  end
end
