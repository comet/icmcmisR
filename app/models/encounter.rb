class Encounter < ActiveRecord::Base
  belongs_to :patient,:foreign_key => 'patient_id'
  has_many :treatments
  has_many :performedtests
  has_many :diagnoses
  before_validation :ensure_type
  validates :complains,:patient_id,:encounter_type,:presence=>true
  def ensure_type

    if patient_id
      encounter = Encounter.find_all_by_patient_id(patient_id)

    else
      errors.add("Patient has to be chosen for an encounter")
    end
    if encounter && encounter.size >0
      self.encounter_type="Re-visit"
    else
      self.encounter_type="Intial Visit"
    end
  end
  def self.day_visit_report(daily=false)
    if daily
      time_range = (Time.zone.now.midnight)..(Time.zone.now.midnight+1.day)
      return Encounter.includes(:diagnoses,:treatments,:tests).order('created_at DESC').where('created_at'=>time_range).all
    else
      return Encounter.includes(:diagnoses,:treatments,:tests).order('created_at DESC').all
    end
  end
  def self.handle_report(query_values)
    #return Encounter.all
    params = query_values || {} # Set params to empty hash if it's nil
    conditions = []
    if !params[:user][:date_from].eql?("") && !params[:user][:date_to].eql?("")
      conditions[0] = "created_at >= ? AND created_at <= ?"
      conditions[1]= params[:user][:date_from].to_date
      conditions<<params[:user][:date_to].to_date
      #conditions[0]=":created_at => #{(params[:user][:date_from].to_date)..(params[:user][:date_to].to_date)}"

    elsif !params[:user][:date_from].eql?("") && params[:user][:date_to].eql?("") #from is set
      conditions[0] = "created_at >= ?"
      conditions[1]=params[:user][:date_from].to_date

    elsif params[:user][:date_from].eql?("") && !params[:user][:date_to].eql?("") #to is set
      conditions[0] = "created_at <= ?"
      conditions[1]=params[:user][:date_to].to_date
    else
      conditions[0] = "created_at <= ?"
      conditions[1]=Time.now.to_date #blanket value for dates
    end
    if params[:complains]&&params[:complains].length>0
      conditions[0]+="AND complains LIKE ?"
      conditions<< "%"+params[:complains]+"%"

    end
    if params[:remarks]&&params[:remarks].length>0
      conditions[0]+="AND remarks LIKE ?"
      conditions<< "%"+params[:remarks]+"%"

    end
    if params[:age]
      conditions[0]+="AND birth_date = ?"
      conditions<< params[:age]
    end
    if params[:treatment].length>0 || params[:diagnosis].length>0
      subqueries =[]
      ids=[]
      if params[:treatment].length>0
        subqueries = Treatment.handle_report(query_values)
      end
      if params[:diagnosis].length>0
        subqueries << Diagnosis.handle_report(query_values)
      end

      if subqueries.size>0
        subqueries.each do|diagnosis|
          d =diagnosis.to_a
          d.each do |single|
            ids << single.encounter_id.to_i if single.encounter_id
          end
          Rails.logger.debug{ids.inspect}
        end
      end
      conditions[0]+="AND id=?"
      conditions<<ids
    end
    encounters=where(conditions)
    #end
  end

end
