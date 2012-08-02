Given /^"sslyze" is installed$/ do
  ensure_python_script_installed('sslyze')
end

When /^I launch an "sslyze" attack with:$/ do |command|
  sslyze_path = path_to_python_script("sslyze")

  command.gsub!('<hostname>', hostname)
  command.gsub!('<sslyze_path>', sslyze_path)
  run command
end

Then /^the key size should be at least (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end