Feature: Run nmap against a target and pass the value of the hostname from the profile.xml.

Background:
  Given nmap is installed

Scenario: Verify server is available on standard web ports
  Given the target hostname is "google.com"
  When I run nmap against the following ports:
    | port_number |
    | 80          |
    | 443         |
  Then the output should contain:
    """
    80/tcp  open  http
    443/tcp open  https
    """

