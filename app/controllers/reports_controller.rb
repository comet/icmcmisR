class ReportsController < ApplicationController
  def index

  end
  def new

  end
  def simple

  end
  def report_view
    @table = Encounter.report_table(:all,
      :conditions => ["created_at >= #{Time.now.to_date}"],
      :only => ["patient.first_name", "created_at"],
      :include => { :patient => { :methods => ["first_name","surname"], :only => {}} } )
    unless @table.empty?
      @table.rename_column("patient.first_name", "Patient")
      @table.rename_columns { |c| c.titleize }
    end
  end
  def patients

    if params[:query]
      if params[:query].eql?("male")
        @records=Patient.find_all_by_gender("male").paginate(:page => params[:page], :per_page => 15)
      elsif params[:query].eql?("female")
        @records=Patient.find_all_by_gender("female").paginate(:page => params[:page], :per_page => 15)
      elsif params[:query].eql?("dead")
        @records=Patient.find_all_by_alive("0").paginate(:page => params[:page], :per_page => 15)
      elsif params[:query].eql?("age")
        @records=Patient.under_five.paginate(:page => params[:page], :per_page => 15)
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'patient'
      end
    else
      @title="Listing all patients"
      @records=Patient.paginate(:page => params[:page], :per_page => 15).all

    end

  end
  def encounters
    if params[:query]
      if params[:query].eql?("daily")
        @encounters = Encounter.day_visit_report(true).paginate(:page => params[:page], :per_page => 15)
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'encounter'
      else
        @encounters = Encounter.day_visit_report.paginate(:page => params[:page], :per_page => 15)
      end
    end
    @records=@encounters
  end
  def diagnoses
    if params[:query]
      if params[:query].eql?("daily")
        @diagnoses = Diagnosis.paginate(:page => params[:page], :per_page => 15).all
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'diagnosis'
      else
        @diagnoses = Diagnosis.paginate(:page => params[:page], :per_page => 15).all
      end
    end

    @records=@diagnoses
  end
  def treatments
    if params[:query]
      if params[:query].eql?("daily")
        #
        @treatments = Treatment.daily_report
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'treatment'
      else
        @treatments = Treatment.all
      end
    end
    @records=@treatments
  end
  def payments
    if params[:query]
      if params[:query].eql?("daily")
        #
        @records = Payment.daily_report.paginate(:page => params[:page], :per_page => 15)
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'payment'
      else
        @records = Payment.paginate(:page => params[:page], :per_page => 15).all
      end
    end

  end
  def custom
    @records=nil
    if request.post?
      Rails.logger.debug{params.inspect}
      if params[:model]
        handler = params[:model]
        if handler.eql?("valuepatient") #strange addition by the form to the param model
          @records= Patient.handle_report(params).paginate(:page => params[:page], :per_page => 15)
          #Rails.logger.debug{@records.inspect}
        elsif handler.eql?("valueuser")
          @records=User.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("valueencounter")
          @records=Encounter.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("valuetreatment")
          @records=Treatment.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("valuediagnosis")
          @records=Diagnosis.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("valuepayment")
          @records=Payment.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("Test")
          @records=Patient.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("SpecialObservation")
          @records=Patient.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        elsif handler.eql?("Billing_plan")
          @records=Patient.handle_report(params).paginate(:page => params[:page], :per_page => 15)
        else
          #General Do nothing
          @records="blank"
        end
      end
    else
      if params[:model]
        @custom=params[:model]
        if @custom.eql?("patient")
          @patient=["name","gender","phone_number","age","death"]
        elsif @custom.eql?("user")
          @user=["name","date_of_birth","gender","phone_number","age","death"]
        elsif @custom.eql?("treatment")
          @treatment=["detail","encounter"]
        elsif @custom.eql?("diagnosis")
          @diagnosis=["detail","encounter"]
        elsif @custom.eql?("test")
          @test=["name","encounter"]
        elsif @custom.eql?("encounter")
          @encounter=["complains","patient"]
        elsif @custom.eql?("payment")
          @payment=["amount","plan","patient"]
        end
      else
        @all=true
      end
    end
  end
  def users
    if params[:query]
      if params[:query].eql?("daily")
        @users=User.all
      elsif params[:query].eql?("custom")
        render :action=>'custom',:model=>'diagnosis'
      else
        @users=User.all
      end
    end
  end
  def csv
    if request.post?
      #Have the model generate a report
      model = params[:model]
      to_date = params[:user][:date_to].nil? ? Time.now.to_date : params[:user][:date_to]
      from_date = params[:user][:date_from].nil? ? Time.now.to_date : params[:user][:date_from]
      case model
      when "patients"
        @table = Encounter.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["patient.first_name","patient.given_name","patient.surname", "created_at","encounter_type"],
          :include => { :patient => { :methods => ["first_name","surname"], :only => {}} },
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"}
        )
        unless @table.empty?
          @table.rename_column("patient.first_name", "First")
          @table.rename_column("patient.surname", "Surname")
          @table.rename_column("patient.given_name", "Middle")
          @table.rename_column("created_at","Date")
          @table.rename_column("encounter_type", "type")
          @table.rename_columns { |c| c.titleize }
        end
      when "encounters"  
        @table = Encounter.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["patient.first_name","patient.given_name","patient.surname", "created_at","encounter_type","diagnoses.detail","treatments.detail"],
          :include => { :patient => { :methods => ["first_name","surname"], :only => {}},
            :diagnoses => { :methods => ["detail"], :only => {}} ,
            :treatments => { :methods => ["detail"], :only => {}} }, 
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"}
        )
        unless @table.empty?
          @table.rename_column("patient.first_name", "First")
          @table.rename_column("patient.surname", "Surname")
          @table.rename_column("patient.given_name", "Middle")
          @table.rename_column("created_at","Date")
          @table.rename_column("encounter_type", "type")
          @table.rename_column("treatments.detail", "treatment")
          @table.rename_column("diagnoses.detail", "Diagnosis")
          @table.rename_columns { |c| c.titleize }
        end
      when "treatments"
        @table = Encounter.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["patient.first_name","patient.given_name","patient.surname", "created_at","encounter_type","treatments.detail"],
          :include => { :patient => { :methods => ["first_name","surname"], :only => {}} ,
            :treatments => { :methods => ["detail"], :only => {}} } ,
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"})
        unless @table.empty?
          @table.rename_column("patient.first_name", "First")
          @table.rename_column("patient.surname", "Surname")
          @table.rename_column("patient.given_name", "Middle")
          @table.rename_column("created_at","Date")
          @table.rename_column("encounter_type", "Type")
          @table.rename_column("treatments.detail", "Treatment")
          @table.rename_columns { |c| c.titleize }
        end  
      when "diagnoses"
        @table = Encounter.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["patient.first_name","patient.given_name","patient.surname", "created_at","encounter_type","diagnoses.detail"],
          :include => { :patient => { :methods => ["first_name","surname"], :only => {}} ,
            :diagnoses => { :methods => ["detail"], :only => {}} } ,
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"})
        unless @table.empty?
          @table.rename_column("patient.first_name", "First")
          @table.rename_column("patient.surname", "Surname")
          @table.rename_column("patient.given_name", "Middle")
          @table.rename_column("created_at","Date")
          @table.rename_column("encounter_type", "Type")
          @table.rename_column("diagnoses.detail", "Diagnoses")
          @table.rename_columns { |c| c.titleize }
        end  
      when "payments"
        @table = Payment.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["payment_for","expeccted_amount", "amount","created_at","payment_method"],
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"})
        unless @table.empty?
          @table.rename_column("payment_method", "Mode")
          @table.rename_column("payment_for", "Item")
          @table.rename_column("amount", "Amount")
          @table.rename_column("created_at","Date")
          @table.rename_column("expeccted_amount", "Cost")
          @table.rename_columns { |c| c.titleize }
        end  
      when "pharmacy"
        @table = Drug.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["name","description", "category","price","created_at"],
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"})
        unless @table.empty?
          @table.rename_column("name", "Name")
          @table.rename_column("Description", "Description")
          @table.rename_column("category", "Category")
          @table.rename_column("Price","Price")
          @table.rename_column("created_at", "Date")
          @table.rename_columns { |c| c.titleize }
        end
      when "users"
        @table = User.report_table(:all,
          :conditions => ["created_at >='#{from_date.to_date}'AND created_at <= '#{to_date.to_date}'"],
          :only => ["first_name","middle_name","surname","username","gender","phone_number","email","created_at"],
          :transforms=>lambda{|r|r["created_at"] = "#{r["created_at"].to_date}"})
        unless @table.empty?
          @table.rename_column("first_name", "First")
          @table.rename_column("surname", "Surname")
          @table.rename_column("given_name", "Middle")
          @table.rename_column("gender","Gender")
          @table.rename_column("email","Email")
          @table.rename_column("address","Address")
          @table.rename_column("phone_number","Phone")
          @table.rename_column("created_at","Date")
          @table.rename_columns { |c| c.titleize }
        end
      end
      if !@table || @table.empty?
        flash[:error]="No records were found matching the dates you gave.Please choose an item and a range."
        redirect_to(:controller =>"reports",:action =>"csv",:query =>model) and return
      else
        file_name = "#{model}_report.csv"
        file = File.open("#{Rails.root.to_s}/#{file_name}", "w") 
        @table =@table.as(:csv)#convert the table to csv
        file.print(@table)
        file.close
        path = File.join(Rails.root.to_s, file_name)
        flash[:message]="File successfully downloaded"
        send_file path,:x_sendfile=>true
        #redirect_to(:controller => "reports", :action => "index")and return
      end
    else
      if params[:query]
        @choice = params[:query]
      else
        #allow export of the entire database
      end
    end
  end
  def to_csv(array,name="csv")
    file_name = "#{name}_report.csv"
    file = File.open("#{Rails.root.to_s}/#{file_name}", "w") 
    #write array to csv file
    
    file.print(@table)
    file.close
    path = File.join(Rails.root.to_s, file_name)
    flash[:message]="File successfully downloaded"
    send_file path,:x_sendfile=>true
    return
    
  end
end
