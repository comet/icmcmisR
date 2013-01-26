class AddLimitDisbursedhif < ActiveRecord::Migration
  def self.up
    add_column :disbursednhifs, :limit, :float,:default=>0
  end

  def self.down
    remove_column :disbursednhifs, :limit
  end
end
