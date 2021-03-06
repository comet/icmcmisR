class TreatmentsController < ApplicationController
  # GET /treatments
  # GET /treatments.xml
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
        @poly=true
        @treatments=Treatment.order('created_at DESC').patient_treatments(params[:patient_id]).paginate(:page => params[:page], :per_page => 15)
      end
    elsif params[:encounter_id]
      @treatments = Encounter.find(params[:encounter_id]).treatments.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
      load_encounter_actions #to set the encounter actions
    else
      @treatments = Treatment.paginate(:page => params[:page], :per_page => 15).all
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
      format.js{
        render :layout => false}
    end
  end

  # GET /treatments/1/edit
  def edit
    load_encounter_actions
    @treatment = Treatment.find(params[:id])
  end

  # POST /treatments
  # POST /treatments.xml
  def create
    @treatment = Treatment.new(params[:treatment])
    #@treatment = Treatment.create(params[:treatment])
    if request.xhr?
      Rails.logger.debug{@treatment.inspect}
    end
    respond_to do |format|
      if @treatment.save
        format.html { redirect_to(@treatment, :notice => 'Treatment was successfully created.') }
        format.xml  { render :xml => @treatment, :status => :created, :location => @treatment }
        format.js{
          render :layout => false}

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @treatment.errors, :status => :unprocessable_entity }
        format.js{
          render :layout => false}
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
