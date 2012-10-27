When /^"garmr" is installed$/ do
  ensure_cli_installed("garmr")
end

When /^I launch a "garmr" attack with:$/ do |command|
  command.gsub!('<target_url>', target_url)
  run command
  @raw_garmr_output = all_output
end