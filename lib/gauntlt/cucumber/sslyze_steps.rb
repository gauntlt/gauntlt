Given /^sslyze is installed$/ do
  steps %{
    When I run `which sslyze.py`
    Then the output should contain:
    """
    sslyze.py
    """
  } 
end

When /^I run sslyze against the hostname$/ do
    steps %{
        When I run `sslyze.py --regular \"#{hostname}\":443`
    }
end

Then /^the key size should be at least (\d+)$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
