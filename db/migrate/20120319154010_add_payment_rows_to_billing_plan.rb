class AddPaymentRowsToBillingPlan < ActiveRecord::Migration
  def self.up
    execute "insert into billing_plans (name,description, maximum_cover, minimum_cover) values ('UAP','UAP insurance', '0', '0'),('APA','APA insurance', '0', '0'),('NHIF','NHIF insurance', '700', '0'),('CIC','CIC insurance', '0', '0'),('CASH','CASH', '0', '0')"
  end

  def self.down
  end
end
