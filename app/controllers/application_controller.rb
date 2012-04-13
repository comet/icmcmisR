class ApplicationController < ActionController::Base
  protect_from_forgery
  #ensure all operations are authorised
  before_filter :login_required,:load_array_paginator
  before_filter { |c| Authorization.current_user = c.current_user }
  def login_required
    return if logged_in?
    flash[:warning]='Please login to continue'
    session[:return_to]=request.fullpath
    redirect_to :controller => "sessions", :action => "login"
    return false
  end
  def load_array_paginator
    #Rails.logger.debug{"Loading paginator library"}
    require 'will_paginate/array'
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
    current_patient
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
  def current_plan
    @current_plan = session[:plan] if session[:plan]
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
  protected

def permission_denied
  flash[:error] = "Sorry, you are not allowed to access that page."
  redirect_to :controller=>"dashboard"
end
end
