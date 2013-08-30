When /^"garmr" is installed$/ do
  ensure_cli_installed("garmr")
end

When /^I launch (?:a|an) "garmr" attack with:$/ do |command|
  run_with_profile command
  @raw_garmr_output = all_output
end
