class Particular < ActiveRecord::Base
  belongs_to :payment
  def self.details(parts)
    if parts.size>0
      #val =self.where(:id=>parts).joins("LEFT OUTER JOIN payables ON particulars.payable_id = payables.id")
      parts=process(parts)
       Particular.find_by_sql("SELECT * FROM `particulars` INNER JOIN payables ON particulars.payable_id = payables.id WHERE (`particulars`.`id` IN ( #{parts}))")
    end

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
