class PharmacyController < ApplicationController
  before_filter :pharmacy
  def index
redirect_to drugs_path
  end
end
