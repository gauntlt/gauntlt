Given /^"sslyze" is installed$/ do
  ensure_python_script_installed('sslyze')
end

When /^I run sslyze against the hostname$/ do
    steps %{
        When I run `sslyze --regular \"#{hostname}\":443`
    }
end

When /^I launch an "sslyze" attack with:$/ do |command|
  path = `echo $SSLYZE_PATH`
  raise if path.strip == ""
  sslyze_command = "python #{path}"

  command.gsub!('<hostname>', hostname)
  command.gsub!('<sslyze_command>', sslyze_command)
  run command
end



Then /^the key size should be at least (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end