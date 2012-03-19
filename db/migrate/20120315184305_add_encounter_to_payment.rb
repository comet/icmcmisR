class AddEncounterToPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :encounter_id, :integer
  end

  def self.down
    remove_column :payments, :encounter_id
  end
end
