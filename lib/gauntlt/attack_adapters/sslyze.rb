Given /^"sslyze" is installed$/ do
  ensure_python_script_installed('sslyze')
end

When /^I launch (?:a|an) "sslyze" attack with:$/ do |command|
  add_to_profile( 'sslyze', path_to_python_script('sslyze') )
  add_to_profile( 'sslyze_path', path_to_python_script('sslyze') )

  run_with_profile command
end
