class Person < ActiveRecord::Base
  #belongs_to :personifiable, :polymorphic => true
  acts_as_reportable
  has_many :patients
  has_one :user
  validates_numericality_of :phone_number
  validates :first_name,:surname,:gender,:created_by,:presence=>true
  validates_length_of :first_name,:surname, :minimum => 3
  validates_length_of :phone_number, :within => 10..14
  #validates :birth_date, :before => Time.now

end
