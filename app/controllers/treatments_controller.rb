class TreatmentsController < ApplicationController
  # GET /treatments
  # GET /treatments.xml
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
      end
      @treatments = Treatment.all
    elsif params[:encounter_id]
      @treatments = Encounter.find(params[:encounter_id]).treatments
      load_encounter_actions #to set the encounter actions
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @treatments }
    end
  end

  # GET /treatments/1
  # GET /treatments/1.xml
  def show
    @treatment = Treatment.find(params[:id])
    load_encounter_actions #to set the encounter actions
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @treatment }
    end
  end

  # GET /treatments/new
  # GET /treatments/new.xml
  def new
    @treatment = Treatment.new
    load_encounter_actions #to set the encounter actions
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @treatment }
    end
  end

  # GET /treatments/1/edit
  def edit
    @treatment = Treatment.find(params[:id])
  end

  # POST /treatments
  # POST /treatments.xml
  def create
    @treatment = Treatment.new(params[:treatment])

    respond_to do |format|
      if @treatment.save
        format.html { redirect_to(@treatment, :notice => 'Treatment was successfully created.') }
        format.xml  { render :xml => @treatment, :status => :created, :location => @treatment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @treatment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /treatments/1
  # PUT /treatments/1.xml
  def update
    @treatment = Treatment.find(params[:id])

    respond_to do |format|
      if @treatment.update_attributes(params[:treatment])
        format.html { redirect_to(@treatment, :notice => 'Treatment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @treatment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /treatments/1
  # DELETE /treatments/1.xml
  def destroy
    @treatment = Treatment.find(params[:id])
    @treatment.destroy

    respond_to do |format|
      format.html { redirect_to(treatments_url) }
      format.xml  { head :ok }
    end
  end
end
