Given /^"sqlmap" is installed$/ do
  ensure_python_script_installed('sqlmap')
end

When /^I launch an? "sqlmap" attack with:$/ do |command|
  sqlmap_path = path_to_python_script("sqlmap")

  command.gsub!('<target_url>', target_url)
  command.gsub!('<sqlmap_path>', sqlmap_path)
  run command
end