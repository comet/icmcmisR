class CreatePivotnhifs < ActiveRecord::Migration
  def self.up
    create_table :pivotnhifs do |t|
      t.integer :patient_id
      t.integer :disbursement_id
      t.float :initial_amount
      t.float :current_balance

      t.timestamps
    end
  end

  def self.down
    drop_table :pivotnhifs
  end
end
