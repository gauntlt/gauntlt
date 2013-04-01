require 'test_helper'

mock_cuke_runtime = Object.new
def mock_cuke_runtime.load_step_definitions
  mock_support_code = Object.new
  def mock_support_code.step_definitions
    [:foo, :bar]
  end

  @support_code = mock_support_code
end

# #find
# roots in cucumber innards to extract step definitions
lambda do
  assert Gauntlt::Stepdef.find(mock_cuke_runtime), :== => [:foo, :bar]
end.call

# #sources
# returns regexp source for each step definition
lambda do
  module StepDef
    def file; end
    def regexp_source; end
  end

  mock_step_def1 = Object.new.extend(StepDef)
  mock_step_def2 = Object.new.extend(StepDef)
  mock_step_definitions = [ mock_step_def1 , mock_step_def2 ]

  stub(Gauntlt::Stepdef, :method => :find, :return => mock_step_definitions) do
    stub(mock_step_def1, :spy => :file) do
      stub(mock_step_def1, :spy => :regexp_source) do
        stub(mock_step_def2, :spy => :file) do
          stub(mock_step_def2, :spy => :regexp_source) do
            Gauntlt::Stepdef.sources(:foo)
          end
        end
      end
    end
  end
end.call