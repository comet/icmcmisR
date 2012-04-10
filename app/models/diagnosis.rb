class Diagnosis < ActiveRecord::Base
  belongs_to :encounter
  def self.patient_diagnoses(patient_id)
    Encounter.includes(:diagnoses).where("patient_id = ?",patient_id).all
  end
  def self.handle_report(query_values)
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
    if params[:diagnosis].length>0
      conditions[0]+="AND detail LIKE ?"
      conditions<< "%"+params[:diagnosis]+"%"

    end
    diagnoses = where(conditions)
  end
end
