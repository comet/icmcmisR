module PaymentsHelper
  def calculate_expected_encounter(arr)
    sum_total=0
    if arr &&  arr.size>0
      arr.each do |item|
        value = item[:price]
        sum_total+=value
      end
    end
    return sum_total

  end
  def calculate_expected(hash)
    @enc= Encounter.includes(:diagnoses,:treatments,:performedtests).find(hash)#joins("INNER JOIN tests on performedtests.test_id=tests.id")
    test_price=0
    treatment_price=0
    #Calculate the value of tests
    if @enc.performedtests
      @enc.performedtests.each do |test|
        ptest=Performedtest.find_by_sql("SELECT * FROM `performedtests` INNER JOIN payables on performedtests.test_id=payables.id WHERE (`performedtests`.`id` = #{test.id})")
        if ptest
          ptest.each do |p|
            test_price+=p.price unless p.price.nil?
          end
        end
      end
    end
    #if @enc.treatments
    #  @enc.treatments.each do |treatment|
    #  treatment_price+=treatment.price
    #end
    #end
    return test_price+treatment_price
  end
  def calculate_expected_set(array_of_particulars)
    if array_of_particulars.size==0
      return 0
    else
      total =0.0
      array_of_particulars.each do |particular|
        price = particular.price
        quantity = particular.quantity? ? particular.quantity : 1
        sum = price * quantity
        total+=sum
      end
      return total
    end
  end
  def compute_daily(array)
    e_amt=0
    p_amt=0
    hash={:expected=>0.0,
      :paid=>0.0,
      :diff=>0.0
    }
    if array.size>0
      array.each do|arr|
        #compute the totals
        if arr.expeccted_amount
          e_amt+=arr.expeccted_amount
        end
        if arr.amount
          p_amt+=arr.amount
        end
      end
      diff=e_amt - p_amt
      hash[:expected]=e_amt
      hash[:paid]=p_amt
      hash[:diff]=diff
    end
    return hash
  end
  def daily_summary(hash,param_req)
    return hash[:param_req].to_s
  end
end
