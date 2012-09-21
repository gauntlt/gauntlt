When /^I launch a "generic" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
end

Given /^the "(.*?)" command line binary is installed$/ do |bin|
  ensure_cli_installed(bin)
end