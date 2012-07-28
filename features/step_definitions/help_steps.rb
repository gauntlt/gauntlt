Then /^I should see a help menu that explains how to invoke gauntlt$/ do
  steps %q{
    Then the output should contain:
    """
      -h, --help
    """
  }
end