When /^I launch (?:a|an) "generic" attack with:$/ do |command|
  run_with_profile command
end

Given /^the "(.*?)" command line binary is installed$/ do |bin|
  ensure_cli_installed(bin)
end

Given /^"(\w+)" is installed in my path$/ do |value|
  ensure_cli_installed("#{value}")
end
