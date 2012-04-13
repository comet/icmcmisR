class AddReceivedFromToPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :received_from, :string
  end

  def self.down
    remove_column :payments, :received_from
  end
end
