class Particular < ActiveRecord::Base
  belongs_to :payment
  def self.details(parts)
    if parts && parts.size>0
      #val =self.where(:id=>parts).joins("LEFT OUTER JOIN payables ON particulars.payable_id = payables.id")
      parts=process(parts)
      Particular.find_by_sql("SELECT particulars.*,payables.name,payables.price,payables.quantity as stock FROM `particulars` INNER JOIN payables ON particulars.payable_id = payables.id WHERE (`particulars`.`id` IN ( #{parts}))")
    end

  end
  def self.details_of_encounter(id)
    @enc= Encounter.includes(:diagnoses,:treatments,:performedtests).find(id)#joins("INNER JOIN tests on performedtests.test_id=tests.id")
    full_array=[]
    content_hash={}
    #Calculate the value of tests
    if@enc
      if @enc.performedtests && @enc.performedtests.size>0
        @enc.performedtests.each do |test|
          ptest=Performedtest.find_by_sql("SELECT performedtests.*,payables.id as the_id,payables.quantity as pquantity,payables.price,payables.name FROM `performedtests` INNER JOIN payables on performedtests.test_id=payables.id WHERE (`performedtests`.`id` = #{test.id})")
          if ptest
            ptest.each do |p|
              unless p.price.nil?
                content_hash={:payable=>p.the_id,:price=>p.price,:quantity=>1,:type=>p.class.to_s,:name=>p.name}
                full_array<<content_hash
              end
             # Rails.logger.debug{full_array.inspect}
            end

          end

          if @enc.treatments && @enc.treatments.size>0
            #Get the value of each of the treatments
            @enc.treatments.each do |treatment|

              #ptreatment=Treatment.find_by_sql("SELECT treatments.*,payables.id as the_id,payables.quantity as quantity,payables.price FROM `treatments` INNER JOIN payables on treatments.treatment_id=payables.id WHERE (`treatments`.`id` = #{treatment.id})")
              ptreatment=Treatment.find_by_sql("SELECT * FROM `treatments` WHERE (`treatments`.`id` = #{treatment.id})")
              if ptreatment
                ptreatment.each do |p|
                  #unless p.price.nil?
                  #  content_hash={:payable=>p.the_id,:quantity=>p.quantity,:price=>p.price,:type=>p.class.to_s}
                  #  full_array<<content_hash
                  #end
                  unless p.detail.nil?
                      content_hash={:payable=>0,:quantity=>0,:price=>0,:type=>p.class.to_s,:name=>p.detail}
                      full_array<<content_hash
                  end
                end
              end
            end
          end
          @enc.diagnoses.each do |treatment|
            #pdiag=Diagnosis.find_by_sql("SELECT diagnosis.*,payables.id as the_id,payables.quantity as quantity,payables.price FROM `diagnosis` INNER JOIN payables on diagnosis.diagnosis_id=payables.id WHERE (`diagnosis`.`id` = #{diagnosis.id})")
            pdiag=nil
            if pdiag
              pdiag.each do |p|
                unless p.price.nil?
                  content_hash={:payable=>p.the_id,:price=>p.price,:quantity=>1,:type=>p.class.to_s}
                  full_array<<content_hash
                end
              end
            end
          end if @enc.diagnoses && @enc.diagnoses.size>0
        end
      end
      return full_array
    end
    return full_array
  end
  def self.process(arr)
    if arr.size>0
      str=""
      arr.each do |content|
        str+=content.to_s+","
      end
      str+="0"
      return str
    end
  end
end
