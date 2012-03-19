class ApplicationController < ActionController::Base
  protect_from_forgery
  #ensure all operations are authorised
  before_filter :login_required
  def login_required
    return if logged_in?
    flash[:warning]='Please login to continue'
    session[:return_to]=request.fullpath
    redirect_to :controller => "sessions", :action => "login"
    return false
  end
  def logged_in?
    current_user
    ! @current_user.nil?
  end
  def load_encounter_actions
    current_patient
    current_encounter
  end
  def load_patient_actions
    @patientactions=true
  end
  def current_user
    @current_user = session[:user] if session[:user]
  end
  def current_patient
    @current_patient = session[:patient] if session[:patient]
  end
  def current_encounter
    @current_encounter = session[:encounter_id] if session[:encounter_id]
  end
  def pharmacy
    @pharmacy=true
  end
  # A before filter for views that only authorized users can access
  def ensure_authorized(error_message)
    if logged_in?
      @person = Person.find(params[:person_id] || params[:id])
      return if current_user?(@person)
      flash[:error] = error_message
      redirect_to root and return
    end
  end
end
