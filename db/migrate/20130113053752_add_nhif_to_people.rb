class AddNhifToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :nhif, :integer,:default=>0
  end

  def self.down
    remove_column :people, :nhif
  end
end
