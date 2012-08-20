class AddDetailToTreatment < ActiveRecord::Migration
  def self.up
    add_column :treatments, :number_per_intake, :float
    add_column :treatments, :number_per_day, :float
    add_column :treatments, :number_of_days, :float
    add_column :treatments, :treated_by, :integer
  end

  def self.down
    remove_column :treatments, :treated_by
    remove_column :treatments, :number_of_days
    remove_column :treatments, :number_per_day
    remove_column :treatments, :number_per_intake
  end
end
