Given /^sslyze is installed$/ do
  begin
    path = `echo $SSLYZE_PATH`
    raise if path.strip == ""

    raise "python not found" unless installed?('python')

    When "I run `echo #{path}`"
    steps %{
      Then the output should contain:
      """
      /sslyze.py
      """
    }
  rescue
    msg = <<-EOS
    sslyze.py not installed or $SSLYZE_PATH not set!

    1. Download sslyze from: https://github.com/iSECPartners/sslyze
    2. In your .zshrc or .bash_profile (or whatever), set $SSLYZE_PATH

       export SSLYZE_PATH=/path/to/sslyze.py

    3. Make sure you have python installed:

       $ which python


EOS
    raise msg
  end
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