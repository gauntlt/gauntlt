require 'spec_helper'

describe Gauntlt do
  subject { Gauntlt }

  describe :has_attack? do
    it "returns true if a cucumber feature exists for the passed name" do
      subject.stub(:attacks).and_return(['foo'])
      subject.should have_attack('foo')
    end
  end

  describe :attacks do
    it "returns the names of all feature files in the cucumber directory" do
      subject.stub(:feature_files).and_return([
        '/foo/bar/a.feature',
        '/foo/bar/b.feature'
      ])

      subject.attacks.should == ['a', 'b']
    end
  end

  describe :feature_files do
    it "returns the full path to each feature file" do
      with_constants :"Gauntlt::FEATURE_GLOB_PATTERN" =>'foo' do
        Dir.stub(:glob).with('foo').and_return(['bar', 'baz'])
        subject.feature_files.should == ['bar', 'baz']
      end
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