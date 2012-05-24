
Given /^nmap is installed$/ do
  steps %{
    When I run `which nmap`
    Then the output should contain:
    """
    nmap
    """
  } 
end

When /^I run nmap against the hostname in the profile on ports (\d+),(\d+)$/ do |arg2, arg3|
  steps %{
    When I run `nmap \"#{@hostname}\" -p80,443`
  }
end


