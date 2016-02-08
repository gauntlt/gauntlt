

When /^I launch (?:a|an) "owasp-zap" attack with:$/ do | command |
  run_with_profile command
end

Then /^the (stderr|stdout) should not contain anything$/
