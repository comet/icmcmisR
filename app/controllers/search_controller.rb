class SearchController < ApplicationController
  def index
    if params[:search] && params[:name]
      hash=params[:name]
    @patients = Patient.existing_patient(hash)
    else
      flash[:error]="Please enter a value to search for in the field."
      redirect_to new_patient_path
    end
  end

  def search
  end

  def results
  end

end
