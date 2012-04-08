class AddQuantityToParticular < ActiveRecord::Migration
  def self.up
    add_column :particulars, :quantity, :integer
  end

  def self.down
    remove_column :particulars, :quantity
  end
end
