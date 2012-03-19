class Sale < ActiveRecord::Base
  def self.sold_items(hash=nil)
    if hash
      #Rails.logger.debug{"using hash"}
      Sale.find_by_sql("SELECT * FROM `sales` INNER JOIN drugs on sales.item_id=drugs.id INNER JOIN people on sales.sold_by=people.id WHERE (`sales`.#{hash[:query_column]} = #{hash[:value]})")
    end
    Sale.find_by_sql("SELECT * FROM `sales` INNER JOIN drugs on sales.item_id=drugs.id INNER JOIN people on sales.sold_by=people.id")
    #Rails.logger.debug{"using "}
  end
end
