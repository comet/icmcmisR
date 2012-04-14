class Stockretake < ActiveRecord::Base
  def self.find_detailed(id=nil)
    if id.nil?
          self.find_by_sql("SELECT `stockretakes`.`id`,quantity_at_update,added_quantity,stockretakes.created_at,payables.name,people.username FROM stockretakes INNER JOIN payables ON stockretakes.payable_id=payables.id INNER JOIN people ON stockretakes.updated_by=people.id ORDER BY stockretakes.created_at DESC")
    else
          self.find_by_sql("SELECT `stockretakes`.`id`,quantity_at_update,added_quantity,stockretakes.created_at,payables.name,people.username FROM stockretakes INNER JOIN payables ON stockretakes.payable_id=payables.id INNER JOIN people ON stockretakes.updated_by=people.id WHERE (`stockretakes`.`id` = #{id})ORDER BY stockretakes.created_at DESC")
    end
  end
end
