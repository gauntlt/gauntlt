require 'test_helper'

subject = stub(Gauntlt::Runtime, :method => :attack_files_for, :return => [:bar]) do
  Gauntlt::Runtime.new(:foo)
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
    stub(Gauntlt::Runtime, :method => :attack_files_for, :return => []) do
      Gauntlt::Runtime.new(:foo)
    end
  rescue
    assert $!, :is_a? => Gauntlt::Runtime::NoFilesFound
    assert $!.message, :=~ => /No files found in path/
  end
end.call

# #run
# returns nil if if Cucumber::Cli::Main.execute succeeds (i.e. returns nil)
lambda do
  mock_cli = Object.new

  stub(Gauntlt::Runtime, :spy => :adapters_dir) do
    stub(mock_cli, :spy => :execute!, :return => nil) do
      stub(Cucumber::Cli::Main, :spy => :new, :return => mock_cli) do
        subject.execute!
      end
    end
  end
end.call

# #run
# raises an error if Cucumber::Cli::Main.execute fails (i.e. returns true)
lambda do
  mock_cli = Object.new

  stub(Gauntlt::Runtime, :spy => :adapters_dir) do
    stub(mock_cli, :spy => :execute!, :return => true) do
      stub(Cucumber::Cli::Main, :spy => :new, :return => mock_cli) do
        begin
          subject.execute!
        rescue
          assert $!, :is_a? => subject.class::ExecutionFailed
        end
      end
    end
  end
end.call