@announce
Feature: Run nmap against a target and pass the value of the hostname from the profile.xml.

Scenario: Verify server is available on standard web ports
  Given the hostname in the profile.xml #this is contained in profile.rb step definition
  When I run `nmap \"#{@hostname}\" -p80,443`
  Then the output should contain:
    """
    80/tcp  open  http
    443/tcp open  https
    """

