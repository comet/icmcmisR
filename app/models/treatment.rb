class Treatment < ActiveRecord::Base
  belongs_to :encounter
  def self.handle_report(query_values)
    return Treatment.all
  end
end
