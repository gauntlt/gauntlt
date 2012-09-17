When /^"curl" is installed$/ do
  ensure_cli_installed("curl")
end

When /^I launch a "curl" attack$/ do
  # curl custom output
  # from:
  #   http://beerpla.net/2010/06/10/how-to-display-just-the-http-response-code-in-cli-curl/
  #
  # for more output variables, see:
  #   http://man.he.net/man1/curl
  @raw_response = `curl --silent --output /dev/null --write-out "%{http_code}" "#{hostname}"`
  @response = {
    :code => @raw_response
  }
end

When /^I launch a "curl" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
end

Then /^the response code should be "(.*?)"$/ do |http_code|
  @response[:code].should == http_code
end

When /^I launch a "cookies" attack$/ do
  set_cookies( cookies_for(hostname) )
end

Then /^the following cookies should be received:$/ do |table|
  names = table.hashes.map{|h| h['name'] }
  names.each do |name|
    cookies.any?{|s| s =~ /^#{name}/}.should be_true
    # TODO: check other values in table
  end
end