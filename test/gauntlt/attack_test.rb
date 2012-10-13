require 'test_helper'

subject = stub(Gauntlt::Attack, :method => :attack_files_for, :return => [:bar]) do
  Gauntlt::Attack.new(:foo)
end

# .initialize
# sets path and attack_files when attack file exists
lambda do
  assert subject.path, :== => :foo
  assert subject.attack_files, :== => [:bar]
end.call

# .initialize
# raises an error if the attack file does not exist
lambda do
  begin
    stub(Gauntlt::Attack, :method => :attack_files_for, :return => []) do
      Gauntlt::Attack.new(:foo)
    end
  rescue
    assert $!, :is_a? => Gauntlt::Attack::NoFilesFound
    assert $!.message, :=~ => /No files found in path/
  end
end.call

# #run
# executes the attack file, specifies failure for undefined steps and specifies the attacks_dir
lambda do
  mock_cli = Object.new

  stub(Gauntlt::Attack, :spy => :adapters_dir, :return => '/bar') do
    stub(subject, :spy => :attack_files, :return => ['/bar/baz.attack']) do
      stub(mock_cli, :spy => :execute!) do
        stub(Cucumber::Cli::Main, :spy => :new, :return => mock_cli) do
          assert subject.run, :== =>  true
        end
      end
    end
  end
end.call

# #run
# returns nil if if Cucumber::Cli::Main.execute succeeds (i.e. returns nil)
lambda do
  mock_cli = Object.new

  stub(Gauntlt::Attack, :spy => :adapters_dir) do
    stub(mock_cli, :spy => :execute!, :return => nil) do
      stub(Cucumber::Cli::Main, :spy => :new, :return => mock_cli) do
        assert subject.run, :== =>  true
      end
    end
  end
end.call

# #run
# raises an error if Cucumber::Cli::Main.execute fails (i.e. returns true)
lambda do
  mock_cli = Object.new

  stub(Gauntlt::Attack, :spy => :adapters_dir) do
    stub(mock_cli, :spy => :execute!, :return => true) do
      stub(Cucumber::Cli::Main, :spy => :new, :return => mock_cli) do
        begin
          subject.run
        rescue
          assert $!, :is_a? => subject.class::ExecutionFailed
        end
      end
    end
  end
end.call