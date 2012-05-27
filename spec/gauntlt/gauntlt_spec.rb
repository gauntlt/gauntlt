require 'spec_helper'

describe Gauntlt do
  subject { Gauntlt }

  describe :has_test? do
    it "returns true if a cucumber feature exists for the passed name" do
      subject.stub(:tests).and_return(['foo'])
      subject.should have_test('foo')
    end
  end

  describe :tests do
    it "returns the names of all feature files in the cucumber directory" do
      subject.stub(:feature_files).and_return([
        '/foo/bar/a.feature',
        '/foo/bar/b.feature'
      ])

      subject.tests.should == ['a', 'b']
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

  describe :run_test do
    it "runs the specified test with the passed options" do
      mock_test = mock('test')
      subject::Test.should_receive(:new).with(:foo, :host => :bar).and_return(mock_test)
      mock_test.should_receive(:run)

      subject.run_test(:foo, :host => :bar)
    end
  end

end