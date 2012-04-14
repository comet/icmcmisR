class Sale < ActiveRecord::Base
  def self.sold_items(hash=nil,where=nil)
    if hash
      #Rails.logger.debug{"using hash"}
      self.find_by_sql("SELECT * FROM `particulars` INNER JOIN payables on particulars.payable_id=payables.id WHERE (`sales`.#{hash[:query_column]} = #{hash[:value]}) ORDER BY particulars.created_at DESC")
    else
      if where.eql?("sales")
      self.find_by_sql("SELECT * FROM `particulars` INNER JOIN payables on particulars.payable_id=payables.id where payables.type='Drug' ORDER BY particulars.created_at DESC")
      else

    self.find_by_sql("SELECT * FROM `particulars` INNER JOIN payables on particulars.payable_id=payables.id ORDER BY particulars.created_at DESC")
      end
      end
  end
end
