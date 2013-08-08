Given /^"arachni" is installed$/ do
  ensure_cli_installed("arachni")
end

When /^I launch (?:a|an) "arachni" attack with:$/ do | command |
  run_with_profile command
end

When /^I launch (?:a|an) "arachni-(.*?)" attack$/ do | type |
  attack_alias = 'arachni-' + type
  attack = load_attack_alias(attack_alias)                
  
  Kernel.puts "Running a #{attack_alias} attack. This attack has this description:\n #{attack['description']}"
  Kernel.puts "The #{attack_alias} attack requires the following to be set in the profile:\n #{attack['requires']}"
  
  run_with_profile attack['command']
end
