Feature: Verify the attack behaviour is correct

  In order to ensure attack behaviour is correct,
  As a software developer or security expert,
  I want to run automated attack tests that will pass or fail.

  Scenario: List available attack steps
    Given at least one attack is in the attacks directory 
    When I run `gauntlt attack --list_available`
    Then it should pass with
      """
      cookies
      curl
      http_methods
      nmap
      """

  Scenario Outline: Run attacks for existing tests
    Given an attack test is defined for "<name>"
    When I run `gauntlt attack --test <name> --host www.google.com`
    Then it should pass
  	Examples:
  	  | name         |
  	  | nmap         |
  	  | cookies      |
  	  | curl         |
  	  | http_methods |


  Scenario: The attack command is run but there are no available tests to be run
    Given there are no available attacks in the attacks directory
    When I run `gauntlt attack --test <name> --host www.google.com`
    Then it should instruct the user to copy attacks from the examples directory to the attacks directory


