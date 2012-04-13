class EncountersController < ApplicationController
  # GET /encounters
  # GET /encounters.xml
  #before_filter :ensure_encounter_actions,:only=>'show'
  before_filter :load_patient_actions,:only=>'show'
  before_filter :current_patient,:only=>'show'
  before_filter :ensure_encounter_actions,:only=>'show'
  def ensure_encounter_actions
    return if current_encounter
    session[:encounter_id]=params[:encounter_id]
    #flash[:error]="You can only perform this action for an new encounter"
  end
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
      @encounters = Patient.find(params[:patient_id]).encounters.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
      end
    else
      @encounters = Encounter.paginate(:page => params[:page], :per_page => 15).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @encounters }
    end
  end

  # GET /encounters/1
  # GET /encounters/1.xml
  def show
    @encounter = Encounter.find(params[:id])
    if @encounter
      session[:encounter_id]=@encounter.id.to_i
      #if params[:patient_id].eql?(current_patient.id.to_s)
      @patientactions=false #disable the patients actions partial
      ensure_encounter_actions
      #@encounteractions=true encounter actions enabled
      #end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @encounter }
    end
  end

  # GET /encounters/new
  # GET /encounters/new.xml
  def new

    if @current_patient.nil?
      current_patient
      Rails.logger.debug{"Creating encounter for @current_patient"}
      Rails.logger.debug{@current_patient.id.to_s}
    end
    @encounter = Encounter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @encounter }
    end
  end

  # GET /encounters/1/edit
  def edit
    if @current_patient.nil?
      current_patient
    end
    @encounter = Encounter.find(params[:id])
  end
  def individual
    @encouters = @current_patient.encounters
    render :action=>index
  end

  # POST /encounters
  # POST /encounters.xml
  def create
    @encounter = Encounter.new(params[:encounter])

    respond_to do |format|
      if @encounter.save
        format.html { redirect_to(@encounter, :notice => 'Encounter was successfully created.') }
        format.xml  { render :xml => @encounter, :status => :created, :location => @encounter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @encounter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /encounters/1
  # PUT /encounters/1.xml
  def update
    @encounter = Encounter.find(params[:id])

    respond_to do |format|
      if @encounter.update_attributes(params[:encounter])
        format.html { redirect_to(@encounter, :notice => 'Encounter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @encounter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /encounters/1
  # DELETE /encounters/1.xml
  def destroy
    @encounter = Encounter.find(params[:id])
    @encounter.destroy

    respond_to do |format|
      format.html { redirect_to(encounters_url) }
      format.xml  { head :ok }
    end
  end
end
