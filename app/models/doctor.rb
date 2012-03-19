class Doctor < Person
  has_many :appointments
  has_many :patients, :through =>:appointments
  #has_one :person, :as => :personifiable
end
