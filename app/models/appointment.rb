class Appointment < ActiveRecord::Base
  belongs_to :patients
  belongs_to  :doctors
end
