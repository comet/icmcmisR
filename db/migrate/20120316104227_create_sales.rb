class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.integer :item_id
      t.float :price
      t.integer :sold_by

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
