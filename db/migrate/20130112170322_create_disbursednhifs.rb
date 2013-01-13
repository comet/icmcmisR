class CreateDisbursednhifs < ActiveRecord::Migration
  def self.up
    create_table :disbursednhifs do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.float :amount
      t.integer :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :disbursednhifs
  end
end
