Given /^sslyze is installed$/ do
  begin
    steps %{
      When I run `which sslyze`
      Then the output should contain:
      """
      sslyze
      """
    }
  rescue
    msg = <<-EOS
    sslyze.py not installed or sslyze alias not set!

    1. Download sslyze from: https://github.com/iSECPartners/sslyze
    2. Create a file named 'sslyze' with the following content:

       #! /usr/bin/env bash
       python /path/to/sslyze.py

    3. Make sure the file is in your path:

       $ which sslyze


EOS
    raise msg
  end
end

When /^I run sslyze against the hostname$/ do
    steps %{
        When I run `sslyze --regular \"#{hostname}\":443`
    }
end

Then /^the key size should be at least (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
