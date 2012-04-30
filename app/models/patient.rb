class Patient < Person

  validate :age_is_sensible
  has_many :appointments
  has_many :doctors, :through =>:appointments
  has_many :encounters

  def age_is_sensible
    if birth_date && birth_date_estimate.length>0
      errors.add(:birth_date_estimate,"cannot be filled if birthdate is known")
    elsif birth_date_estimate && !birth_date
      num = Integer(birth_date_estimate) rescue nil
      if num.nil?  || num<1
        errors.add(:birth_date_estimate,"has to be a number")
      end
    end

  end
  def self.under_five
    #All patients under the age of five
    return Patient.find_by_sql("SELECT `people`.* FROM `people` WHERE (`people`.`type` = 'Patient') AND (`people`.`birth_date_estimate` < 5)")
  end
  def self.existing_patient(hash)
    return Patient.find_by_sql("SELECT `people`.* FROM `people` WHERE (`people`.`type` = 'Patient') AND (`people`.`first_name` LIKE '%#{hash}%' OR `people`.`given_name` LIKE '%#{hash}%' OR `people`.`surname` LIKE '%#{hash}%')")
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
    if params[:gender].length>0
      conditions[0]+="AND gender = ?"
      conditions<< params[:gender]

    end
    if params[:age].length>0
      conditions[0]+="AND birth_date = ?"
      conditions<< params[:age]

    end
    if params[:death].length>0
      conditions[0]+="AND alive = ?"
      conditions<< params[:death]
    end
    patients = where(conditions)
    #Rails.logger.debug{patients.inspect}
  end
end
