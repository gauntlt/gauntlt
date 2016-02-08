When /^I launch (?:a|an) "owasp-zap" attack$/ do
  puts "==========="
  Gauntlt::Support::ZapHelper.launch_attack
end

