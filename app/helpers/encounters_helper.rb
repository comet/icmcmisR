module EncountersHelper
  def get_tab_class(tab_name)
    if params[:controller].eql?(tab_name)
      "selected"
    end
  end
end
