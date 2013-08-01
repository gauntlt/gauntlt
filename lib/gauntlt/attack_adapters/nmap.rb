# TODO: figure out if there's a way to namespace these step definitions
#
@attack_steps = {'nmap-fast' => 'nmap -F <hostname>'}

When /^"nmap" is installed$/ do
  ensure_cli_installed("nmap")
end

When /^I launch an "nmap" attack with:$/ do |command|
  run_with_profile command
end

When /^I launch a "nmap-(.*?)" attack$/ do |step_name|_
  step = 'nmap-' + step_name
  nmap_attack = @attack_steps[step] || raise("Unknown attack step #{step}")
  run_with_profile nmap_attack
end
