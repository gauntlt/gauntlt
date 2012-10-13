require 'spec_helper'

describe Gauntlt::Attack do
  before do
    Gauntlt::Attack.stub(:attack_files_for).with(:foo).and_return([:bar])
  end

  subject{
    Gauntlt::Attack.new(:foo)
  }

  describe :initialize do
    context "attack file exists for passed name" do
      it "sets path and attack_files" do
        subject.path.should == :foo
        subject.attack_files.should == [:bar]
      end
    end

    context "attack_files_for returns an empty array" do
      it "raises an error if the attack file does not exist" do
        Gauntlt::Attack.stub(:attack_files_for).with(:foo).and_return([])

        expect {
          Gauntlt::Attack.new(:foo)
        }.to raise_error Gauntlt::Attack::NoFilesFound
      end
    end
  end

  describe :run do
    it "executes the attack file, specifies failure for undefined steps and specifies the attacks_dir" do
      subject.class.should_receive(:adapters_dir).and_return('/bar')
      subject.should_receive(:attack_files).and_return(['/bar/baz.attack'])

      mock_cli = mock(Cucumber::Cli::Main)
      mock_cli.should_receive(:execute!)
      Cucumber::Cli::Main.should_receive(:new).with(['/bar/baz.attack', '--strict', '--require', '/bar']).and_return(mock_cli)

      subject.run.should be_true
    end

    it "returns nil if if Cucumber::Cli::Main.execute succeeds (i.e. returns nil)" do
      subject.stub(:attacks_dir)

      mock_cli = mock(Cucumber::Cli::Main)
      mock_cli.should_receive(:execute!).and_return(nil)
      Cucumber::Cli::Main.stub(:new).and_return(mock_cli)

      subject.run.should be_true
    end

    it "raises an error if Cucumber::Cli::Main.execute fails (i.e. returns true)" do
      subject.stub(:attacks_dir)

      mock_cli = mock(Cucumber::Cli::Main)
      mock_cli.should_receive(:execute!).and_return(true)
      Cucumber::Cli::Main.stub(:new).and_return(mock_cli)

      expect {
        subject.run
      }.to raise_error(subject.class::ExecutionFailed)
    end
  end
end