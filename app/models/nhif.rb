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
end
