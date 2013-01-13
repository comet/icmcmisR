class CreateNhifs < ActiveRecord::Migration
  def self.up
    create_table :nhifs do |t|
      t.integer :patient_id
      t.integer :encounter_id
      t.integer :disbursement_id
      t.float :amount_charged
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :nhifs
  end
end
