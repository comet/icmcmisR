class AddEncounterTypeToEncounters < ActiveRecord::Migration
  def self.up
    add_column :encounters, :encounter_type, :string
  end

  def self.down
    remove_column :encounters, :encounter_type
  end
end
