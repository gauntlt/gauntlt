Feature: Verify security behaviour is correct

  In order to ensure security behaviour is correct,
  As a software developer or security expert,
  I want to run automated tests that will pass or fail.

  Scenario: List defined verification steps
    Given a verification test is defined for "nmap"
    When I run `gauntlt verify --list`
    Then it should pass with:
      """
      cookies
      curl
      http_methods
      nmap
      """

  Scenario Outline: Run verification for existing test
    Given a verification test is defined for "<name>"
    When I run `gauntlt verify --test <name> --host www.google.com`
    Then it should pass
  	Examples:
  	  | name         |
  	  | nmap         |
  	  | cookies      |
  	  | curl         |
  	  | http_methods |