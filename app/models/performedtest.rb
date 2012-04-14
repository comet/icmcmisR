class Performedtest < ActiveRecord::Base
  belongs_to :encounter
  validates :test_id,:presence=>true
  validates :encounter_id,:presence=>true
  validates :patient_id,:presence=>true
  validates_numericality_of :test_id,:encounter_id,:patient_id
  #validate :proper_tests
  def proper_tests
    if patient_id && encounter_id && test_id
      encounter = Performedtest.find_by_sql("SELECT * from performedtests WHERE patient_id='#{patient_id}' AND encounter_id='#{encounter_id}' AND test_id='#{test_id}'")

    else
      errors.add("Patient,encounter and test have to be defined")
    end

    if encounter && encounter.size >0
      errors.add("You cannot add a test more than once",:test_id)
    end
  end
  def self.patient_tests(hash=nil)
    if(hash)
    self.find_by_sql("SELECT payables.id as decoy_id,performedtests.*,payables.name,payables.description,payables.price FROM `performedtests` INNER JOIN payables on performedtests.test_id=payables.id WHERE (`performedtests`.#{hash[:query_column]} = #{hash[:value]})")
    else
     self.find_by_sql("SELECT payables.id as decoy_id,performedtests.*,payables.name,payables.description,payables.price FROM `performedtests` INNER JOIN payables on performedtests.test_id=payables.id")
    end
  end
  def self.lab_request_form(val = nil)
    vals=Particular.process(val)
    self.find_by_sql("SELECT * FROM `performedtests` INNER JOIN payables on performedtests.test_id=payables.id WHERE (`performedtests`.`id` IN (#{vals}))")
  end
end
