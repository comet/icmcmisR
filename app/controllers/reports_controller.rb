class ReportsController < ApplicationController
  def index

  end
  def new

  end
  def simple

  end
  def patients
    if params[:query]
      if params[:query].eql?("male")
        @patients=Patient.find_all_by_gender("male")
      elsif params[:query].eql?("female")
        @patients=Patient.find_all_by_gender("female")
      elsif params[:query].eql?("dead")
        @patients=Patient.find_all_by_alive("0")
      elsif params[:query].eql?("age")
        @patients=Patient.under_five
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'patient'
      end
    else
      @title="Listing all patients"
      @patients=Patient.all
    end

  end
  def encounters
    if params[:query]
      if params[:query].eql?("daily")
        @encounters = Encounter.day_visit_report(true)
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'encounter'
      else
        @encounters = Encounter.day_visit_report
      end
    end
  end
  def diagnoses
    if params[:query]
      if params[:query].eql?("daily")
        @diagnoses = Diagnosis.all
      elsif params[:query].eql?("custom")
        redirect_to :action=>'custom',:model=>'diagnosis'
      else
        @diagnoses = Diagnosis.all
      end
    end
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
  end
  def custom
    @records=nil
    if request.post?
      Rails.logger.debug{params.inspect}
      if params[:model]
        handler = params[:model]
        if handler.eql?("valuepatient") #strange addition by the form to the param model
          @records= Patient.handle_report(params)
          #Rails.logger.debug{@records.inspect}
        elsif handler.eql?("valueuser")
          @records=User.handle_report(params)
        elsif handler.eql?("valueencounter")
          @records=Encounter.handle_report(params)
        elsif handler.eql?("valuetreatment")
          @records=Treatment.handle_report(params)
        elsif handler.eql?("valuediagnosis")
          @records=Diagnosis.handle_report(params)
          #Rails.logger.debug{@records.inspect}
        elsif handler.eql?("Test")
          @records=Patient.handle_report(params)
        elsif handler.eql?("SpecialObservation")
          @records=Patient.handle_report(params)
        elsif handler.eql?("Billing_plan")
          @records=Patient.handle_report(params)
        else
          #General Do nothing
          @records="blank"
        end
      end
    else
      if params[:model]
        @custom=params[:model]
        if @custom.eql?("patient")
          @patient=["name","date_of_birth","gender","phone_number","age","death"]
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
