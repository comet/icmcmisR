class AddDetailsToTest < ActiveRecord::Migration
  def self.up
    add_column :tests, :price, :float
    add_column :tests, :other_info, :text
  end

  def self.down
    remove_column :tests, :other_info
    remove_column :tests, :price
  end
end
