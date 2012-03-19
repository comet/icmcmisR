class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.float :amount
      t.text :payment_for
      t.integer :received_by
      t.float :expeccted_amount
      t.string :payment_method
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
