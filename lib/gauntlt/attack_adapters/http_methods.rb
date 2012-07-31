When /^"curl" is installed$/ do
  ensure_cli_installed("curl")
end

When /^I launch a "curl" attack$/ do
  @response = Curl::Easy.http_get(hostname)
end

When /^I launch a "curl" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
end