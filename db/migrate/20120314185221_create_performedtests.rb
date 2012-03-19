class CreatePerformedtests < ActiveRecord::Migration
  def self.up
    create_table :performedtests do |t|
      t.integer :test_id
      t.integer :encounter_id
      t.integer :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :performedtests
  end
end
