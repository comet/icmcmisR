class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.integer :patient_id
      t.date :app_date
      t.integer :physician_id
      t.integer :set_by
      t.string :subject_matter

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
