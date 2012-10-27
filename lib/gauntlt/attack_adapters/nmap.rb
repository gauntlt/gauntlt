# TODO: figure out if there's a way to namespace these step definitions

When /^"nmap" is installed$/ do
  ensure_cli_installed("nmap")
end

When /^I launch an "nmap" attack with:$/ do |command|
  run_with_profile command
end