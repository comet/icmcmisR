module PharmacyHelper
  def  get_pharmacy_tab_class(tab_name)
    if tab_name.eql?("current_stock") && params[:controller].eql?("drugs")
      "selected"
    elsif  tab_name.eql?("sold_stock")&& params[:controller].eql?("sales")
      "selected"
    elsif tab_name.eql?"payments" && params[:custom].eql?("pharm")
      'selected'
    end
  end
end
