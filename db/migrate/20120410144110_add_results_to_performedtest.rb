class AddResultsToPerformedtest < ActiveRecord::Migration
  def self.up
    add_column :performedtests, :results, :string
    add_column :performedtests, :comments, :text
  end

  def self.down
    remove_column :performedtests, :comments
    remove_column :performedtests, :results
  end
end
