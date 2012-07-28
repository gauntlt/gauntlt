require 'spec_helper'

describe Gauntlt::Attack do
  before do
    File.stub(:exists?).with(:existent).and_return(true)
    File.stub(:exists?).with(:nonexistent).and_return(false)

    Gauntlt::Attack.any_instance.stub(:attack_file_for).and_return(:existent)
  end

  subject{
    Gauntlt::Attack.new(:foo)
  }

  describe :initialize do
    context "attack file exists for passed name" do
      it "sets name and opts" do
        subject.name.should == :foo
        subject.opts.should == {}
      end
    end

    context "attack file does not exist for passed name" do
      it "raises an error if the attack file does not exist" do
        Gauntlt::Attack.any_instance.stub(:attack_file_for).and_return(:nonexistent)

        expect {
          Gauntlt::Attack.new(:bar)
        }.to raise_error Gauntlt::Attack::NotFound
      end
    end
  end

  describe :attack_file_for do
    it "returns a file name based on name and attacks_dir" do
      Gauntlt::Attack.any_instance.unstub(:attack_file_for)
      File.stub(:exists?).and_return(true)
      subject.should_receive(:attacks_dir).and_return('/bar')
      subject.attack_file_for('baz').should == '/bar/baz.attack'
    end
  end

  describe :base_dir do
    it "returns the full path for the attack.rb file" do
      File.should_receive(:dirname).and_return(:foo)
      File.should_receive(:expand_path).with(:foo)

      subject.base_dir
    end
  end

  describe :attacks_dir do
    it "joins attacks to base_dir" do
      subject.should_receive(:base_dir).and_return(:bar)
      File.should_receive(:join).with(:bar, 'attacks')

      subject.attacks_dir
    end
  end

  describe :run do
    it "executes the attack file and specifies the attacks_dir" do
      subject.should_receive(:attacks_dir).and_return('/bar')
      subject.should_receive(:attack_file).and_return('/bar/baz.attack')
      Cucumber::Cli::Main.should_receive(:execute).with(['/bar/baz.attack', '--require', '/bar'])

      subject.run
    end
  end
end