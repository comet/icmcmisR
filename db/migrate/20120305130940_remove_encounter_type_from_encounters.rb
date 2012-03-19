class RemoveEncounterTypeFromEncounters < ActiveRecord::Migration
  def self.up
    remove_column :encounters, :type
  end

  def self.down
  end
end
