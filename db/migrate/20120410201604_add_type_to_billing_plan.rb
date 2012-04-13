class AddTypeToBillingPlan < ActiveRecord::Migration
  def self.up
    add_column :billing_plans, :type, :string
  end

  def self.down
    remove_column :billing_plans, :type
  end
end
