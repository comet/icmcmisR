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
end
