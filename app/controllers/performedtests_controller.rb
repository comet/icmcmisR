class PerformedtestsController < ApplicationController
  # GET /performedtests
  # GET /performedtests.xml
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
        #create
        query_string ={:query_column=>'patient_id',:value=>params[:patient_id]}
        @performedtests = Performedtest.patient_tests(query_string)#joins("test").find_all_by_patient_id(params[:patient_id])
      end

    elsif params[:encounter_id]
      query_string ={:query_column=>'encounter_id',:value=>params[:encounter_id]}
      @performedtests = Performedtest.patient_tests(query_string)
      #@performedtests = Encounter.find(params[:encounter_id]).performedtests
      load_encounter_actions #to set the encounter actions
    else
      @performedtests = Performedtest.joins("INNER JOIN tests on performedtests.test_id=tests.id").all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @performedtests }
    end
  end

  # GET /performedtests/1
  # GET /performedtests/1.xml
  def show
    if session[:tests]
      @performedtest= Performedtest.lab_request_form(session[:tests])
      session[:tests]=nil
    else
      query_string ={:query_column=>'id',:value=>params[:id]}
      @performedtest = Performedtest.patient_tests(query_string)#Performedtest.find(params[:id])
    end
    load_encounter_actions #to set the encounter actions

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @performedtest }
    end
  end

  # GET /performedtests/new
  # GET /performedtests/new.xml
  def new
    if !request.xhr?
      if @current_patient.nil?
        current_patient

        # Rails.logger.debug{"Creating test for current_patient "+@current_patient.id.to_s}
      end
      if params[:encounter_id]
        @encounter= params[:encounter_id]
      else
        current_encounter #jua kali code to fix encounter error
      end
    end
    @performedtest = Performedtest.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @performedtest }
      format.js {render :layout => false}
    end
  end

  # GET /performedtests/1/edit
  def edit
    if @current_patient.nil?
      current_patient
      current_encounter #jua kali code to fix encounter error
      Rails.logger.debug{"Creating test for current_patient "+@current_patient.id.to_s}
    end
    @performedtest = Performedtest.find(params[:id])
  end

  # POST /performedtests
  # POST /performedtests.xml
  def create
    #@performedtest = Performedtest.new(params[:performedtest])
    @tests=[]
    @ptest=[]
    params.each do |test|
      #
      testa=test.to_a
      #Rails.logger.debug{testa.inspect}
      @tests << testa[0] if testa[1].eql?("1")
    end
    @tests.each do |test|
      @performedtest = Performedtest.new(params[:performedtest])
      @performedtest.test_id=test.to_i
      if @performedtest.save
        Rails.logger.error{"Successfully created the test "+test.to_s}
        @ptest<<@performedtest.id
      else
        #Do nothing
        Rails.logger.error{"Could not save the test "+test.to_s}
      end
    end
    respond_to do |format|
      #if @performedtest.save
      session[:tests]=@ptest
      format.html { redirect_to(@performedtest, :notice => 'Performedtest was successfully created.') }
      format.xml  { render :xml => @performedtest, :status => :created, :location => @performedtest }
      format.js {render :layout => false}
      # else
      #   format.html { render :action => "new" }
      #   format.xml  { render :xml => @performedtest.errors, :status => :unprocessable_entity }
      #   format.js {render :layout => false}
      # end
    end
  end

  # PUT /performedtests/1
  # PUT /performedtests/1.xml
  def update
    @performedtest = Performedtest.find(params[:id])

    respond_to do |format|
      if @performedtest.update_attributes(params[:performedtest])
        format.html { redirect_to(@performedtest, :notice => 'Performedtest was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @performedtest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /performedtests/1
  # DELETE /performedtests/1.xml
  def destroy
    @performedtest = Performedtest.find(params[:id])
    @performedtest.destroy

    respond_to do |format|
      format.html { redirect_to(performedtests_url) }
      format.xml  { head :ok }
    end
  end
end
