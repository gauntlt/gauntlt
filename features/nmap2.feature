@announce
Feature: Run nmap against a target 

Scenario: Verify server is available on standard web ports
  Given the hostname in the profile.xml
  When I run `nmap \"#{@hostname}\" -p80,443`
  Then the output should contain:
    """
    80/tcp  open  http
    443/tcp open  https
    """

