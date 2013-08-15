require 'test_helper'

# #new
# initializes runtime with passed arguments
lambda do
  stub(Gauntlt::Runtime, :spy => :new) do
    Gauntlt::Attack.new(:foo)
  end
end.call

mock_runtime = Object.new
subject = stub(Gauntlt::Runtime, :method => :new, :return => mock_runtime) do
  Gauntlt::Attack.new(:foo)
end

# #run
# executes and returns value
lambda do
  stub(mock_runtime, :method => :execute!, :return => :anything_at_all) do
    assert subject.run, :== =>  :anything_at_all
  end
end.call