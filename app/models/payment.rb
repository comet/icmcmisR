class Payment < ActiveRecord::Base
  has_many :particulars
  def self.bind_particulars(id,partics)
   parts = partics
   parts.each do |part|
     @p =Particular.find(part)
     @p.payment_id=id
     if @p.save
       true
     else
       false
     end
   end
  end
  def self.find_detailed(id)
    Payment.find_by_sql("SELECT * FROM payments INNER JOIN particulars ON payments.id=particulars.payment_id INNER JOIN payables ON particulars.payable_id=payables.id INNER JOIN people ON people.id=payments.received_by WHERE payments.id=#{id}" )
  end
end
