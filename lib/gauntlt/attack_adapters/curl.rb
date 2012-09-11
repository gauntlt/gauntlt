Then /^the response code should be "(.*?)"$/ do |http_code|
  @response[:code].should == http_code
end