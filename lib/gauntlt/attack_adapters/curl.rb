When /^"curl" is installed$/ do
  ensure_cli_installed("curl")
end

When /^I launch a "curl" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)
  run command
end

Then /^the response code should be "(.*?)"$/ do |http_code|
  @response[:code].should == http_code
end

Then /^the following cookies should be received:$/ do |table|
  names = table.hashes.map{|h| h['name'] }
  names.each do |name|
    cookies.any?{|s| s =~ /^#{name}/}.should be_true
    # TODO: check other values in table
  end
end