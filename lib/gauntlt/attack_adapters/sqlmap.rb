Given /^"sqlmap" is installed$/ do
  ensure_python_script_installed('sqlmap')
end

When /^I launch (?:a|an) "sqlmap" attack with:$/ do |command|
  add_to_profile('sqlmap_path', path_to_python_script("sqlmap"))
  add_to_profile('sqlmap', path_to_python_script("sqlmap"))

  run_with_profile command
end
