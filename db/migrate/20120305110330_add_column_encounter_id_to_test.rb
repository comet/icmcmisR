class AddColumnEncounterIdToTest < ActiveRecord::Migration
  def self.up
    add_column :tests, :encounter_id, :integer
  end

  def self.down
    remove_column :tests, :encounter_id
  end
end
