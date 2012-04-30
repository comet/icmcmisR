# To change this template, choose Tools | Templates
# and open the template in the editor.

class MockEncounter
  def initialize
    @encounters=Encounter.day_visit_report(true)

  end
end
