class CreateEncounters < ActiveRecord::Migration
  def self.up
    create_table :encounters do |t|
      t.string :type
      t.text :complains
      t.integer :patient_id
      t.text :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :encounters
  end
end
