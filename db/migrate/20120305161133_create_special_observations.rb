class CreateSpecialObservations < ActiveRecord::Migration
  def self.up
    create_table :special_observations do |t|
      t.string :ob_name
      t.text :description
      t.integer :doctor_id
      t.integer :patient_id
      t.text :other_remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :special_observations
  end
end
