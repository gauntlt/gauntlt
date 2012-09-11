When /^"curl" is installed$/ do
  ensure_cli_installed("curl")
end

When /^I launch a "curl" attack$/ do
  # curl custom output
  # from:
  #   http://beerpla.net/2010/06/10/how-to-display-just-the-http-response-code-in-cli-curl/
  @raw_response = `curl --silent --output /dev/null --write-out "%{http_code}" "#{hostname}"`
  @response = {
    :code => @raw_response
  }
end

When /^I launch a "curl" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
end