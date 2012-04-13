module SettlementsHelper
  def calculate_expected_settlement(array_of_particulars)
    if array_of_particulars.size==0
      return 0
    else
      total =0.0
      array_of_particulars.each do |particular|
        expected = particular.expeccted_amount
        paid = particular.amount
        sum = expected - paid
        total+=sum
      end
      return total
    end
  end
end
