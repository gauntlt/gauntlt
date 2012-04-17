Feature: Run nmap against a target 

Background:
  Given nmap is installed

Scenario: Verify server is available on standard web ports
  When I run `nmap google.com -p80,443`
  Then the output should contain:
    """
    80/tcp  open  http
    443/tcp open  https
    """

