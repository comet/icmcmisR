class Settlement < Payment
  def self.find_detailed_set(plan)
    parts=""
    claim_array=[]
    if plan
      claims = Payment.where("payment_method=?",plan.name).to_a
      if claims && claims.size>0
        claims.each do| c|
          claim_array<<c.id
        end
        parts =Particular.process(claim_array)
      else
        parts =0
      end
      #Rails.logger.debug{parts.inspect}
      Settlement.find_by_sql("SELECT * FROM `particulars` INNER JOIN payments ON particulars.payment_id = payments.id WHERE (`particulars`.`payable_id` IN ( #{parts}))AND(`payments`.`type`='Settlement')")
    else
      Settlement.all
    end
  end
  def self.bind_to_claims(id,partics)
    parts = partics.to_a
    #Rails.logger.debug{parts.inspect}
    parts.each do |part|
      @p =ClaimParticular.new
      @p.payable_id=part.id
      @p.payment_id=id
      @p.status="done"
      if @p.save
        true
      else
        false
      end
    end
  end
  def self.find_detailed_parts(id)
    if id && !id.blank?
      Settlement.find_by_sql("SELECT * FROM `particulars` INNER JOIN payments ON particulars.payment_id = payments.id WHERE (`particulars`.`payable_id`='#{id}')")
    else
      []
    end
  end

end
