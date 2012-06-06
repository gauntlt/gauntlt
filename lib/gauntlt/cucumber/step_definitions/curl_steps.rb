When /^I run curl against the hostname$/ do
  @response = Curl::Easy.perform(hostname) do |curl|
    curl.follow_location = false
  end
end

Then /^the response code should be "(.*?)"$/ do |http_code|
  @response.response_code.should == http_code.to_i
end