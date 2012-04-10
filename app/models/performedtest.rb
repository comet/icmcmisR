class Performedtest < ActiveRecord::Base
  belongs_to :encounter
  validates :test_id,:presence=>true
  validates :encounter_id,:presence=>true
  validates :patient_id,:presence=>true
  #validates_numericality_of :test_id,:encounter_id,:patient_id
  def self.patient_tests(hash)
    Performedtest.find_by_sql("SELECT * FROM `performedtests` INNER JOIN tests on performedtests.test_id=tests.id WHERE (`performedtests`.#{hash[:query_column]} = #{hash[:value]})")
  end
  def self.lab_request_form(val = nil)
    vals=Particular.process(val)
    Performedtest.find_by_sql("SELECT * FROM `performedtests` INNER JOIN payables on performedtests.test_id=payables.id WHERE (`performedtests`.`id` IN (#{vals}))")
  end
end
