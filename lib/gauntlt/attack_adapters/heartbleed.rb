When /^I launch (?:a|an) "Heartbleed" attack with:$/ do |command|
  run_with_profile command
end
When /^"Heartbleed" is installed$/ do
  ensure_cli_installed("Heartbleed")
end

