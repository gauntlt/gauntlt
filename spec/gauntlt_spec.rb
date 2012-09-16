require 'spec_helper'

describe Gauntlt do
  subject { Gauntlt }

  describe :attacks do
    it "returns the names of all attack files in the attacks directory" do
      subject.stub(:attack_adapters).and_return([
        '/foo/bar/a.rb',
        '/foo/bar/b.rb'
      ])

      subject.attacks.should == ['a', 'b']
    end
  end

  describe :attack_adapters do
    it "returns the full path to each attack adapter" do
      stub_const "Gauntlt::ATTACK_ADAPTERS_GLOB_PATTERN",'foo'
      Dir.stub(:glob).with('foo').and_return(['bar', 'baz'])
      subject.attack_adapters.should == ['bar', 'baz']
    end
  end

  describe :attack do
    it "runs the specified test with the passed options" do
      mock_test = mock('test')
      subject::Attack.should_receive(:new).with(:foo, []).and_return(mock_test)
      mock_test.should_receive(:run)

      subject.attack(:foo)
    end
  end

end