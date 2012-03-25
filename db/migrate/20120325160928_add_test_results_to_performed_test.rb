class AddTestResultsToPerformedTest < ActiveRecord::Migration
  def self.up
    add_column :performedtests, :test_results, :string
    add_column :performedtests, :additional_comments, :text
  end

  def self.down
    remove_column :performedtests, :additional_comments
    remove_column :performedtests, :test_results
  end
end
