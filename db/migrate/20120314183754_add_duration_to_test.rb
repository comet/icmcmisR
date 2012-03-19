class AddDurationToTest < ActiveRecord::Migration
  def self.up
    add_column :tests, :duration, :double
  end

  def self.down
    remove_column :tests, :duration
  end
end
