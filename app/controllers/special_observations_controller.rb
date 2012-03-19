class SpecialObservationsController < ApplicationController
  # GET /special_observations
  # GET /special_observations.xml
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
      end
      @special_observations = SpecialObservation.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @special_observations }
    end
  end

  # GET /special_observations/1
  # GET /special_observations/1.xml
  def show
    @special_observation = SpecialObservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @special_observation }
    end
  end

  # GET /special_observations/new
  # GET /special_observations/new.xml
  def new
    @special_observation = SpecialObservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @special_observation }
    end
  end

  # GET /special_observations/1/edit
  def edit
    @special_observation = SpecialObservation.find(params[:id])
  end

  # POST /special_observations
  # POST /special_observations.xml
  def create
    @special_observation = SpecialObservation.new(params[:special_observation])

    respond_to do |format|
      if @special_observation.save
        format.html { redirect_to(@special_observation, :notice => 'Special observation was successfully created.') }
        format.xml  { render :xml => @special_observation, :status => :created, :location => @special_observation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @special_observation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /special_observations/1
  # PUT /special_observations/1.xml
  def update
    @special_observation = SpecialObservation.find(params[:id])

    respond_to do |format|
      if @special_observation.update_attributes(params[:special_observation])
        format.html { redirect_to(@special_observation, :notice => 'Special observation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @special_observation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /special_observations/1
  # DELETE /special_observations/1.xml
  def destroy
    @special_observation = SpecialObservation.find(params[:id])
    @special_observation.destroy

    respond_to do |format|
      format.html { redirect_to(special_observations_url) }
      format.xml  { head :ok }
    end
  end
end
