class Payment < ActiveRecord::Base
  has_many :particulars
  validates :expeccted_amount,:payment_method,:received_by,:amount,:presence=>true
  validate :amount_is_enough
  def self.bind_particulars(id,partics)
   parts = partics
   parts.each do |part|
     @p =Particular.find(part)
     @p.payment_id=id
     if @p.save
       true
     else
       false
     end
   end
  end
  def self.payments_specific(hash)
    Payment.find_by_sql("SELECT * FROM payments INNER JOIN particulars ON payments.id=particulars.payment_id INNER JOIN payables ON particulars.payable_id=payables.id INNER JOIN people ON people.id=payments.received_by WHERE payments.#{hash[:query_column]} = #{hash[:value]}")
  end
  def self.find_detailed(id=nil)
    if id.nil?
    Payment.find_by_sql("SELECT payments.id as payment_id,people.id as user_id,name,amount,username,expeccted_amount,payment_method FROM payments INNER JOIN particulars ON payments.id=particulars.payment_id INNER JOIN payables ON particulars.payable_id=payables.id INNER JOIN people ON people.id=payments.received_by ORDER BY payments.created_at DESC" )
    else
    Payment.find_by_sql("SELECT * FROM payments INNER JOIN particulars ON payments.id=particulars.payment_id INNER JOIN payables ON particulars.payable_id=payables.id INNER JOIN people ON people.id=payments.received_by WHERE payments.id=#{id} payments.created_at" )
    end
    end
    def amount_is_enough
      if amount && amount < expeccted_amount
        errors.add(:amount,"cannot be less than amount due")
      end

    end
    def self.daily_report
      time_range = (Time.zone.now).to_date
      #time_to =(Time.zone.now.midnight+1.day).to_date
      return Payment.find_by_sql("SELECT payments.id as payment_id,people.id as user_id,name,amount,username,expeccted_amount,payment_method FROM payments INNER JOIN particulars ON payments.id=particulars.payment_id INNER JOIN payables ON particulars.payable_id=payables.id INNER JOIN people ON people.id=payments.received_by WHERE payments.created_at >= #{time_range} " )
    end
    def self.handle_report(query_values)
    params = query_values || {} # Set params to empty hash if it's nil
    conditions = []

    if !params[:user][:date_from].eql?("") && !params[:user][:date_to].eql?("")
      conditions[0] = "created_at >= ? AND created_at <= ?"
      conditions[1]= params[:user][:date_from].to_date
      conditions<<params[:user][:date_to].to_date
     #conditions[0]=":created_at => #{(params[:user][:date_from].to_date)..(params[:user][:date_to].to_date)}"

    elsif !params[:user][:date_from].eql?("") && params[:user][:date_to].eql?("") #from is set
      conditions[0] = "created_at >= ?"
      conditions[1]=params[:user][:date_from].to_date

    elsif params[:user][:date_from].eql?("") && !params[:user][:date_to].eql?("") #to is set
      conditions[0] = "created_at <= ?"
      conditions[1]=params[:user][:date_to].to_date
    else
      conditions[0] = "created_at <= ?"
      conditions[1]=Time.now.to_date #blanket value for dates
    end
    if params[:billing_plan].length>0
      conditions[0]+="AND payment_method = ?"
      conditions<< params[:billing_plan]

    end
    if params[:amount].length>0
      conditions[0]+="AND expeccted_amount >= ?"
      conditions<< params[:amount]

    end
    payments = where(conditions)
    #Rails.logger.debug{patients.inspect}
  end
end
