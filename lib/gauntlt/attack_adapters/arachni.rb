Given /^"arachni" is installed$/ do
  ensure_cli_installed("arachni")
end

When /^I launch (?:a|an) "arachni" attack with:$/ do | command |
  run_with_profile command
end

When /^I launch (?:a|an) "arachni-(.*?)" attack$/ do | type |
  attack_alias = 'arachni-' + type
  arachni_version = get_cli_version("arachni")
  attack = load_attack_alias(attack_alias, arachni_version)                
 
  if arachni_version.length > 0
      optional_version_info = " with version #{arachni_version} of arachni"
  end

  Kernel.puts "Running a #{attack_alias} attack#{optional_version_info}. This attack has this description:\n #{attack['description']}"
  Kernel.puts "The #{attack_alias} attack requires the following to be set in the profile:\n #{attack['requires']}"
  
  run_with_profile attack['command']
end
