class PatientsController < ApplicationController
  # GET /patients
  # GET /patients.xml
  before_filter :load_patient_actions,:only=>'show'
  def quick_labs
    @performedtest = Performedtest.new({})

    if request.post?
      #process both entities presented
      begin
        @performedtest.save
      rescue exception
        #do nothing
      end
      @patient=nil
      patient={}
      tests={}
      names=params[:names]
      if names
        surname,fname,sname =names.split(" ")
        patient={:first_name=>fname,
          :given_name=>sname,
          :surname=>surname,
          :address=>params[:address],
          :gender=>params[:gender][:gender],
          :phone_number=>params[:phone_number],
          :birth_date_estimate=>params[:birth_date_estimate],
          :created_by=>params[:created_by],
          :alive=>params[:alive]
        }

      end
      @patient= Patient.new(patient)
      if @patient.save
        #create an encounter
        encounter={:encounter_type=>"tests",
          :complains=>"tests only",
          :remarks=>"tests",
          :patient_id=>@patient.id
        }
        @encounter = Encounter.new(encounter)
        if @encounter.save
          @tests=[]
          @ptest=[]
          Rails.logger.debug{"Successfully created encounter"}
          params.each do |test|
            #load selected tests
            testa=test.to_a
            #Rails.logger.debug{testa.inspect}
            @tests << testa[0] if testa[1].eql?("1") && !testa[0].eql?("alive")
          end
          ptest_hash={:patient_id=>@encounter.patient_id,
            :encounter_id=>@encounter.id
          }
          @tests.each do |test|
            @performedtest = Performedtest.new(ptest_hash)
            @performedtest.test_id=test.to_i
            if @performedtest.save
              Rails.logger.error{"Successfully created the test "+test.to_s}
              @ptest<<@performedtest.id
            else
              #Do nothing
              Rails.logger.error{"Could not save the test "+test.to_s}
            end
          end
          #load this new encounter into session
          session[:tests]=@ptest
          session[:encounter_id]=@encounter.id.to_i
          session[:patient]=@patient
          current_patient
          current_encounter
          #redirect to performedtests page
          redirect_to(@performedtest, :notice => 'Performedtest was successfully created.To view all patient tests click the tests tab')
        end
      else
        Rails.logger.debug{@patient.errors.inspect}
        if @performedtest.errors.nil?
          @performedtest.errors={}
          @performedtest.errors=@performedtest.errors.clone.update(@patient.errors)
        end
        Rails.logger.debug{@performedtest.errors.inspect}

        render :action=>'quick_labs'
      end

    else

    end
  end
  def index
    @patients = Patient.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.xml
  def show
    @patient = Patient.find(params[:id])
    session[:patient]=@patient if @patient
    #load current patient to the global variable to show the actions
    #repeat to ensure session value has been set
    load_patient_actions
    respond_to do |format|
      format.html #{render :layout=>'patientsactions'}# show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new

    @patient=Patient.new

    #redirect_to :controller => "people", :action => "new",:type=>'patient'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit

    @patient = Patient.find(params[:id])
  end

  # POST /patients
  # POST /patients.xml
  def create
    @patient = Patient.new(params[:patient])

    respond_to do |format|
      if @patient.save
        format.html { redirect_to(@patient, :notice => 'Patient was successfully created.') }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    @patient = Patient.find(params[:id])

    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(@patient, :notice => 'Patient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url) }
      format.xml  { head :ok }
    end
  end
end
