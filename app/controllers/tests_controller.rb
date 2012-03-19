class TestsController < ApplicationController
  # GET /tests
  # GET /tests.xml

  def index
    if params[:patient_id]
      Rails.logger.debug{"Using one"}
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
      end

      elsif params[:encounter_id]
        Rails.logger.debug{"Using two"}
      @tests = Encounter.find(params[:encounter_id]).tests
      load_encounter_actions #to set the encounter actions
    elsif params.nil?
      Rails.logger.debug{"Using three"}
      @test =Encounter.find(@current_encounter).tests

    else
      @tests = Test.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.xml
  def show
    @test = Test.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/new
  # GET /tests/new.xml
  def new
    @test = Test.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = Test.find(params[:id])
  end

  # POST /tests
  # POST /tests.xml
  def create
    @test = Test.new(params[:test])
    respond_to do |format|
      if @test.save
        format.html { redirect_to(@test, :notice => 'Test was successfully created.') }
        format.xml  { render :xml => @test, :status => :created, :location => @test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.xml
  def update
    @test = Test.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to(@test, :notice => 'Test was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.xml
  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to(tests_url) }
      format.xml  { head :ok }
    end
  end
end
