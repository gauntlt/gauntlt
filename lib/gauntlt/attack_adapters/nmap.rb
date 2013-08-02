# TODO: figure out if there's a way to namespace these step definitions
#
#read in JSON
When /^"nmap" is installed$/ do
  ensure_cli_installed("nmap")
end

When /^I launch an "nmap" attack with:$/ do |command|
  run_with_profile command
end

When /^I launch a "nmap-(.*?)" attack$/ do |type|
  step_name = 'nmap-' + type
  nmap_attack = load_attack(step_name)                
  
  puts "Running a #{step_name} attack step. This attack has this description:\n #{nmap_attack['description']}"
  
  run_with_profile nmap_attack['command']
end
