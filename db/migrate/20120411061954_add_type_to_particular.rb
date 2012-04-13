class AddTypeToParticular < ActiveRecord::Migration
  def self.up
    add_column :particulars, :type, :string
    add_column :particulars, :given_by, :string
  end

  def self.down
    remove_column :particulars, :given_by
    remove_column :particulars, :type
  end
end
