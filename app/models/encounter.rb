class Encounter < ActiveRecord::Base
  belongs_to :patient,:foreign_key => 'patient_id'
  has_many :treatments
  has_many :performedtests
  has_many :diagnoses
  def self.day_visit_report(daily=false)
    if daily
      time_range = (Time.zone.now.midnight)..(Time.zone.now.midnight+1.day)
      return Encounter.includes(:diagnoses,:treatments,:tests).where('created_at'=>time_range).all
    else
    return Encounter.includes(:diagnoses,:treatments,:tests).all
    end
  end
  def self.handle_report(query_values)
    return Encounter.all
  end

end
