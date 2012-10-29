Then /^debug$/ do
  require 'debugger'
  debugger
  nil
end

require 'pathname'
Given /^I copy the attack files from the "(.*?)" folder$/ do |folder|
  Dir.glob("./#{folder}/**/*.attack").each do |path|
    name     = Pathname.new(path).basename.to_s
    contents = File.read(path)
    write_file(name, contents)
  end
end

Given /^the following attack files exist:$/ do |table|
  table.hashes.each do |hsh|
    check_file_presence [hsh['filename']], true
  end
end

require 'rack/handler/webrick'
Given /^scapegoat is running on port (\d+)$/ do |port|
  if Scapegoat.running?
    if Scapegoat.port != port.to_i
      raise "Scapegoat already running on port #{Scapegoat.port} (not #{port})"
    end
  else
    Scapegoat.set :port, port.to_i
    Scapegoat.set :logging, nil

    if RUBY_PLATFORM == 'java'
      Thread.new { Scapegoat.run! }
    else
      @scapegoat_pid = Process.fork do
        trap(:INT) { ::Rack::Handler::WEBrick.shutdown }
        Scapegoat.run!
        exit # manually exit; otherwise this sub-process will re-run the specs that haven't run yet.
      end
    end
  end
end

Then /^scapegoat should quit$/ do
  if @scapegoat_pid
    Process.kill('INT', @scapegoat_pid)
    begin
      Process.wait(@scapegoat_pid)
    rescue Errno::ECHILD
      # ignore this error...I think it means the child process has already exited.
    end
  end
end
