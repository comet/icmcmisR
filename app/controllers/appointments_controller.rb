class AppointmentsController < ApplicationController
  def index
    if params[:patient_id]
      if params[:patient_id].eql?(current_patient.id.to_s)
        @patientactions=true
      end
      @appointments = Patient.find(params[:patient_id]).appointments
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @encounters }
    end
  end

  def show
  end

  def destroy
  end

end
