# TODO: figure out if there's a way to namespace these step definitions
#
#read in JSON
When /^"nmap" is installed$/ do
  ensure_cli_installed("nmap")
end

When /^I launch (?:a|an) "nmap" attack with:$/ do |command|
  run_with_profile command
end

When /^I launch (?:a|an) "nmap-(.*?)" attack$/ do |type|
  attack_alias = 'nmap-' + type
  nmap_attack = load_attack_alias(attack_alias)                
  
  Kernel.puts "Running a #{attack_alias} attack. This attack has this description:\n #{nmap_attack['description']}"
  
  run_with_profile nmap_attack['command']
end
