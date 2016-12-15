When /^I launch (?:a|an) "httprint" attack with:$/ do |command|
  run_with_profile command
end
When /^"httprint" is installed$/ do
  ensure_cli_installed("httprint")
end

