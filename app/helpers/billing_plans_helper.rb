module BillingPlansHelper
  def get_tab_class(tab_name)
    if params[:controller].eql?(tab_name)
      "selected"
    elsif tab_name.eql?("claims")
      "selected"
    end
  end
  def calculate_bp_summary(val_array_a,val_array_b,side)
    side_a=0
    side_b=0
    if val_array_a  && val_array_a.size>0
      val_array_a.each do |arr|
        if arr.amount && arr.amount>0 && arr.expeccted_amount && arr.expeccted_amount>0
          side_a+=arr.expeccted_amount - arr.amount

        end
      end

    end

    if val_array_b  && val_array_b.size>0
      val_array_b.each do |arr|
        if arr.amount && arr.amount>0 && arr.expeccted_amount #&& arr.expeccted_amount>0
          side_b+=arr.expeccted_amount - arr.amount
          #Rails.logger.debug{"showing b"+side_b.to_s}
        end
      end
    end
    if  side.eql?("claims")
      return side_a
    elsif side.eql?("settle")
      return side_b
    else
      return side_a-side_b
    end
  end
end
