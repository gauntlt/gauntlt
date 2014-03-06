module Cucumber
  class Undefined < StandardError
    def initialize(step_name)
      super %{Not a recognized gauntlt attack step: "#{step_name}"\nCheck available gauntlt steps with this command 'gauntlt --allsteps'}
      @step_name = step_name
    end
  end
end
 

