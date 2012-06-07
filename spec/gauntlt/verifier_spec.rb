require 'spec_helper'

describe Gauntlt::Verifier do
  describe :initialize do
    it "sets name and opts" do
      gv = Gauntlt::Verifier.new(:foo, :bar)
      
      gv.name.should == :foo
      gv.opts.should == :bar
    end
  end
  
  describe :feature_file do
    it "returns a file name based on name and cuke_dir" do
      gv = Gauntlt::Verifier.new(:foo)
      gv.should_receive(:cuke_dir).and_return('/bar')
      gv.feature_file.should == '/bar/foo.feature'
    end
  end
  
  describe :base_dir do
    it "returns the full path for the verifier.rb file" do
      File.should_receive(:dirname).and_return(:foo)
      File.should_receive(:expand_path).with(:foo)
      
      Gauntlt::Verifier.new(:foo).base_dir
    end
  end
  
  describe :cuke_dir do
    it "joins cucumber to base_dir" do
      gv = Gauntlt::Verifier.new(:foo)
      gv.should_receive(:base_dir).and_return(:bar)
      File.should_receive(:join).with(:bar, 'cucumber')
      
      gv.cuke_dir
    end
  end
  
  describe :run do
    it "executes the feature file and specifies the cuke_dir" do
      gv = Gauntlt::Verifier.new(:foo)
      gv.should_receive(:cuke_dir).and_return('/bar')
      gv.should_receive(:feature_file).and_return('/bar/baz.feature')
      Cucumber::Cli::Main.should_receive(:execute).with(['/bar/baz.feature', '--require', '/bar'])
      
      gv.run
    end
  end
end