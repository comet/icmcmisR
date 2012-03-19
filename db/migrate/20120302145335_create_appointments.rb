class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.integer :physician_id
      t.integer :patient_id
      t.string :subject_matter
      t.date :appointment_date

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
