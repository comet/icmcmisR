class ChangeQuantityToFloat < ActiveRecord::Migration
  def self.up
    change_column :particulars, :quantity, :float
  end

  def self.down
    remove_column :particulars, :quantity
  end
end
