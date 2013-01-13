class CreateNhifPivot < ActiveRecord::Migration
  def self.up
    create_table :nhif_pivot do |t|
    t.timestamps
    end
    add_column :nhif_pivot,:patient_id,:integer
    add_column :nhif_pivot,:disbursement_id,:integer
    add_column :nhif_pivot,:initial_amount,:float
    add_column :nhif_pivot,:current_balance,:float
  end

  def self.down
    remove_column :nhif_pivot, :patient_id
    remove_column :nhif_pivot,:disbursement_id
    remove_column :nhif_pivot,:initial_amount
    remove_column :nhif_pivot,:current_balance
    drop_table :nhif_pivot
  end
end
