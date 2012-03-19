module PatientsHelper
  def get_tab_class(tab_name)
    if params[:controller].eql?(tab_name)
      "selected"
    elsif  (tab_name.eql?"overview")&&(params[:controller].eql?("patients"))
      "selected"
    end
  end
end
