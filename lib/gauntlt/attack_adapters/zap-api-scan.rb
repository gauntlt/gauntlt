Given /^"zap-api-scan" is installed$/ do
  ensure_python_script_installed('zap-api-scan')
end

When /^I launch (?:a|an) "zap-api-scan" attack on the host "(.*)" whose documentation is available in "(.*)"$/ do |host,doc|
  run_with_profile "zap-api-scan -f openapi -O " + host +" -t "+ doc
end

When /^I launch (?:a|an) "zap-api-scan" attack on a web service whose documentation is available in "(.*)"$/ do |doc|
    run_with_profile "zap-api-scan -f openapi "+" -t "+ doc
end
  

When /^I launch (?:a|an) "zap-api-scan" attack with:$/ do |command|
  run_with_profile command
end

Given /^I wait for (\d+) seconds?$/ do |n|
    sleep(n.to_i)
end