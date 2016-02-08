When /^I launch (?:a|an) "owasp-zap" attack with:$/ do
  launch_attack()
end

Then /^the (stderr|stdout) should not contain anything$/