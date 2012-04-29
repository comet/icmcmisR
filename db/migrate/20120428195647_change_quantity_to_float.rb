class ChangeQuantityToFloat < ActiveRecord::Migration
  def self.up
    change_column :particulars, :quantity, :float
  end

  def self.down
  end
end
