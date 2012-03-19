class AddPersonifiableTypeToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :personifiable_type, :string
  end

  def self.down
    remove_column :people, :personifiable_type
  end
end
