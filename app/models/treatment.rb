class Treatment < ActiveRecord::Base
  belongs_to :encounter
  acts_as_reportable
  validates :encounter_id,:payable_id,:presence=>true
  def self.patient_treatments(patient_id)
    Encounter.includes(:treatments).where("patient_id = ?",patient_id).all
  end
  def self.daily_report
    time_from = (Time.zone.now.midnight).to_time
    time_to =(Time.zone.now.midnight+1.day).to_time
    return self.find_by_sql("SELECT * FROM treatments WHERE treatments.created_at >=' #{time_from}' AND treatments.created_at <= '#{time_to}' ORDER BY treatments.created_at DESC" )
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
    if params[:treatment].length>0
      conditions[0]+="AND detail LIKE ?"
      conditions<< "%"+params[:treatment]+"%"

    end
    treatments = where(conditions)#.joins("INNER JOIN particulars ON treatments.encounter_id=encounters.id")
  end
end
