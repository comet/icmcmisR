class AddNhifToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :Nhif, :integer
  end

  def self.down
    remove_column :patients, :Nhif
  end
end
