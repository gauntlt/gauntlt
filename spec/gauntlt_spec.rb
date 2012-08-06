require 'spec_helper'

describe Gauntlt do
  subject { Gauntlt }

  describe :has_attack? do
    it "returns true if an attack exists for the passed name" do
      subject.stub(:attacks).and_return(['foo'])
      subject.should have_attack('foo')
    end
  end

  describe :attacks do
    it "returns the names of all attack files in the attacks directory" do
      subject.stub(:attack_files).and_return([
        '/foo/bar/a.rb',
        '/foo/bar/b.rb'
      ])

      subject.attacks.should == ['a', 'b']
    end
  end

  describe :attack_files do
    it "returns the full path to each attack file" do
      stub_const "Gauntlt::ATTACK_GLOB_PATTERN",'foo'
      Dir.stub(:glob).with('foo').and_return(['bar', 'baz'])
      subject.attack_files.should == ['bar', 'baz']
    end
  end

  describe :attack do
    it "runs the specified test with the passed options" do
      mock_test = mock('test')
      subject::Attack.should_receive(:new).with(:foo, :host => :bar).and_return(mock_test)
      mock_test.should_receive(:run)

      subject.attack(:foo, :host => :bar)
    end
  end

end