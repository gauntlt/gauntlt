When /^the target hostname is "(.*?)"$/ do |host|
  set_hostname host
end

When /^the target URL is "(.*?)"$/ do |u|
  set_target_url u
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