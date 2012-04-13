class BillingPlan < ActiveRecord::Base
  validates :name,:description,:presence=>true
  validates_numericality_of :minimum_cover,:maximum_cover
  validates_uniqueness_of :name
  def self.load_claims(plan_id)
    conditions=[]
    name = BillingPlan.find(plan_id).name
    conditions[0]="payment_method = ?"
    conditions<<name
    Payment.where(conditions)
  end
end
