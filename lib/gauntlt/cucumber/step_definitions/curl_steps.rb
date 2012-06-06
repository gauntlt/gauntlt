When /^I run curl against the hostname$/ do
  @response = Curl::Easy.http_get(hostname)
end

Then /^the response code should be "(.*?)"$/ do |http_code|
  @response.response_code.should == http_code.to_i
end

When /^I make a "(.*?)" request to the hostname$/ do |http_method|
  method_name = http_method.upcase
  run "curl -i -X #{method_name} http://#{hostname}"
end