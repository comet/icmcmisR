class Disbursednhif < ActiveRecord::Base
  def update_pivot
  
    #Get all nhif patients and create pivot tables for this disbursement
    nhif_patients = Patient.where("nhif='1'")
    #Rails.logger.debug{nhif_patients.inspect}
    #result[]
    nhif_patients.each do |patient|
      patient = {:patient_id=>patient.id,
        :disbursement_id=>id, 
        :initial_amount=>amount,
        :current_balance=>amount
      }
      @pivot = Pivotnhif.new(patient)
      if !@pivot.save
        Rails.logger.error{"Failed saving a pivot nhif record"}
        Rails.logger.error{@pivot}
      end
    end
    true
  end
  def self.update_pivot_individual(patient_id)
    disb = Disbursednhif.last
    if disb
      id = disb.id
      amount =disb.amount      
      patient = {:patient_id=>patient_id,
        :disbursement_id=>id, 
        :initial_amount=>amount,
        :current_balance=>amount
      }
      @pivot = Pivotnhif.new(patient)
      if !@pivot.save
        Rails.logger.error{"Failed saving a pivot nhif record"}
        Rails.logger.error{@pivot}
      end
      true
    else
      Rails.logger.error{"No disbursement in place,failed saving the record"}
    end
    
    
  end
end
