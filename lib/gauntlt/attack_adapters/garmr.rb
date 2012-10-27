When /^"garmr" is installed$/ do
  ensure_cli_installed("garmr")
end

When /^I launch a "garmr" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
  @raw_garmr_output = all_output
end