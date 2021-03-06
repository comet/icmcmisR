class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.xml
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
        @appointment = @current_patient.appointments.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
        #Rails.logger.debug{@appointment.inspect}
        #@encounters = Patient.find(params[:patient_id]).encounters.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
      end
    else
    @appointments = Appointment.order('created_at DESC').paginate(:page => params[:page], :per_page => 15).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @appointments }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.xml
  def show
      if params[:id]
      @appointment = Appointment.find(params[:id])
      end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @appointment }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.xml
  def new
    @appointment = Appointment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appointment }
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.xml
  def create
    @appointment = Appointment.new(params[:appointment])
    @appointment.app_date = params[:app_date]
    @appointment.physician_id=params[:physician_id].to_s
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to(@appointment, :notice => 'Appointment was successfully created.') }
        format.xml  { render :xml => @appointment, :status => :created, :location => @appointment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /appointments/1
  # PUT /appointments/1.xml
  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        format.html { redirect_to(@appointment, :notice => 'Appointment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.xml
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to(appointments_url) }
      format.xml  { head :ok }
    end
  end
end
