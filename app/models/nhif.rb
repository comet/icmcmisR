class Nhif < ActiveRecord::Base
#validate :valid_amount
  def self.this_patient(id)
    where("patient_id = '#{id}'")
  end
  def self.validate_amount(p_id,amount)
    disb_id = Disbursednhif.last.id
    
    pivot = Pivotnhif.where("patient_id = ? AND disbursement_id = ?", p_id, disb_id)
    #pivot.first.current_balance
    #Rails.logger.debug{pivot.first.current_balance}
    expected_amount = pivot.first.current_balance
    if amount > expected_amount.to_f
    #errors.add(:amount_charged,"This amount is higher than the current balance of this patient")    
    false
    else
      true
    end
  end
  def deduct_pivot(p_id,amount)
    disb_id = Disbursednhif.last.id
    pivot = Pivotnhif.where("patient_id = ? AND disbursement_id = ?", p_id, disb_id)
    #pivot.first.current_balance
    #Rails.logger.debug{pivot.first.current_balance}
    expected_amount = pivot.first.current_balance
    new_balance = expected_amount-amount
    
    Pivotnhif.update_all({:current_balance=> new_balance},["patient_id = ? AND disbursement_id = ?", p_id, disb_id])
  end
  def self.daily
    time_range = (Time.zone.now.midnight)..(Time.zone.now.midnight+1.day)
    where('created_at'=>time_range).all
  end
  def self.this_disbursement(disb_id)
    where("disbursement_id = ?", disb_id)
  end
  def self.ensure_disbursement_limit(amount_requested)
    #all the nhif payments under this scheme should not exceed a certain amount
    disb = Disbursednhif.last
    limit = disb.limit
    pivot = Nhif.where("disbursement_id = ?", disb.id)
    amount = 0
     if pivot && pivot.size >0
       pivot.each do |piv|
         amount = amount + piv.amount_charged
       end
     end
     limit_user = limit - amount
    if limit_user < amount_requested
      false
    else
      true
    end
  end
end
