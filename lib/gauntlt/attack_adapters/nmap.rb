# TODO: figure out if there's a way to namespace these step definitions

When /^"nmap" is installed$/ do
  ensure_cli_installed("nmap")
end

When /^the target hostname is "(.*?)"$/ do |host|
  set_hostname host
end

When /^I launch an "nmap" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
end
