Feature: Run curl against a target and pass the value of the hostname from the profile.xml.

Background:
  Given "curl" is installed

Scenario: Verify a 301 is received from a curl
  Given the target hostname is "google.com"
  When I run curl against the hostname
  Then the response code should be "301"