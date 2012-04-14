class CreateStockretakes < ActiveRecord::Migration
  def self.up
    create_table :stockretakes do |t|
      t.integer :payable_id
      t.integer :quantity_at_update
      t.integer :added_quantity
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :stockretakes
  end
end
