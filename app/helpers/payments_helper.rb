module PaymentsHelper
  def calculate_expected(hash)
    @enc= Encounter.includes(:diagnoses,:treatments,:performedtests).find(hash)#joins("INNER JOIN tests on performedtests.test_id=tests.id")

    test_price=0
    treatment_price=0
    #Calculate the value of tests
    if @enc.performedtests
      @enc.performedtests.each do |test|

        ptest=Performedtest.find_by_sql("SELECT * FROM `performedtests` INNER JOIN tests on performedtests.test_id=tests.id WHERE (`performedtests`.`id` = #{test.id})")
        ptest.each do |p|
          test_price+=p.price unless p.price.nil?
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
end
