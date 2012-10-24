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
  Gauntlt::Scapegoat.set :port, port.to_i
  Gauntlt::Scapegoat.set :logging, nil
  @scapegoat_pid = Process.fork do
    trap(:INT) { ::Rack::Handler::WEBrick.shutdown }
    Gauntlt::Scapegoat.run!
    exit # manually exit; otherwise this sub-process will re-run the specs that haven't run yet.
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
