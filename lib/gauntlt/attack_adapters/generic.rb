When /^I launch a "generic" attack with:$/ do |command|
  run_with_profile command
end

Given /^the "(.*?)" command line binary is installed$/ do |bin|
  ensure_cli_installed(bin)
end