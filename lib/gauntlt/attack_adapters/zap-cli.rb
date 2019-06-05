Given /^"zap-cli" is installed$/ do
  ensure_python_script_installed('zap-cli')
end

When /^I launch (?:a|an) "zap-cli" attack with:$/ do |command|
  run_with_profile command
end
