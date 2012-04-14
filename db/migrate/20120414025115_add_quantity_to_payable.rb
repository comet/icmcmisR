class AddQuantityToPayable < ActiveRecord::Migration
  def self.up
    add_column :payables, :quantity, :integer
  end

  def self.down
    remove_column :payables, :quantity
  end
end
