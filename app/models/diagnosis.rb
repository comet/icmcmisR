class Diagnosis < ActiveRecord::Base
  belongs_to :encounter
  def self.patient_diagnoses(patient_id)
    Encounter.includes(:diagnoses).where("patient_id = ?",patient_id).all
  end
  def self.handle_report(query_values)
    return Diagnosis.all
  end
end
