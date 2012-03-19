class Patient < Person
  has_many :appointments
  has_many :doctors, :through =>:appointments
  has_many :encounters
  def self.under_five
    #All patients under the age of five
    return Patient.find_by_sql("SELECT `people`.* FROM `people` WHERE (`people`.`type` = 'Patient') AND (`people`.`birth_date_estimate` < 5)")
  end
  def self.existing_patient(hash)
    return Patient.find_by_sql("SELECT `people`.* FROM `people` WHERE (`people`.`type` = 'Patient') AND (`people`.`first_name` LIKE '%#{hash}%' OR `people`.`given_name` LIKE '%#{hash}%' OR `people`.`surname` LIKE '%#{hash}%')")
  end
  def self.handle_report(query_values)
    return Patient.all
  end
end
