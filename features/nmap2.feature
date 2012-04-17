Feature: Run nmap against a target and pass the value of the hostname from the profile.xml.

Background:
  Given nmap is installed

Scenario: Verify server is available on standard web ports
  Given the hostname in the profile.xml
  When I run nmap against the hostname in the profile on ports 80,443
  Then the output should contain:
    """
    80/tcp  open  http
    443/tcp open  https
    """

