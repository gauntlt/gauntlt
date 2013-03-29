require 'test_helper'
require 'gauntlt/stepdef'

mock_cuke = Object.new

mock_support_code = Object.new

hash_steps = [{:source => "some", :file => "aruba"},
              {:source => "other", :file => "other"}]
mock_steps = hash_steps.map do |step|
  OpenStruct.new(step.merge({:to_hash => step}))
end

subject = stub(Cucumber::Runtime, :spy => :new,
               :return => mock_cuke) do
  stub(mock_cuke, :spy => :load_step_definitions,
       :return => mock_cuke) do
    stub(mock_cuke, :spy => :instance_variable_get,
         :return => mock_support_code) do
      stub(mock_support_code, :spy => :step_definitions,
           :return => mock_steps) do
        Gauntlt::Stepdef.new
      end
    end
  end
end

# .initialize
# set the steps from cucumber
lambda do
  assert subject.instance_variable_get("@steps"), :== => mock_steps
end.call

# .definitions
# set the proper step kind
lambda do
  assert subject.definitions.first['kind'], :== => "aruba"
  assert subject.definitions.last['kind'], :== => "gauntlt"
end.call
