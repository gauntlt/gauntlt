module Cucumber
  class Undefined < StandardError
    def initialize(step_name)
      super %{Undefined gauntlt attack step: "#{step_name}"}
      @step_name = step_name
    end
  end
end
 
