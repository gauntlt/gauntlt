Then /^the response code should be "(.*?)"$/ do |http_code|
  @response.response_code.should == http_code.to_i
end