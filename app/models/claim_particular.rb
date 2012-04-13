class ClaimParticular < Particular
=begin
  def self.load_pending(plan=nil)
    settled=[]
    settledparts = ClaimParticular.all
    if settledparts
      settledparts.each do |settle|
        settled<<settle.id
      end
    else
      #return all the payments of this method
      payments=Payment.where("payment_method=?",plan)
    end
    if settled.size>0
      #load all payments except those in this array
      pending(settled)
    end
  end
=end
  def self.load_pending(plan=nil)
    settled=[]
    settledparts = ClaimParticular.all
    if settledparts.size>0
      settledparts.each do |settle|
        settled<<settle.payable_id
      end
    else
      #return all the payments of this method
      payments=Payment.where("payment_method=?",plan)
      return payments
    end
    if settled.size>0
      #load all payments except those in this array
      pending(settled,plan)
    end

  end

  private
  def self.pending(parts,plan)
    if parts.size>0
      #Rails.logger.debug{parts}
      #val =self.where(:id=>parts).joins("LEFT OUTER JOIN payables ON particulars.payable_id = payables.id")
      parts=process(parts)
       Particular.find_by_sql("SELECT * FROM `payments` WHERE (`payments`.`id` NOT IN ( #{parts})) AND (`payments`.`payment_method`='#{plan}')")
    end
  end
end
