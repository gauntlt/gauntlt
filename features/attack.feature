Feature: Verify the attack behaviour is correct

  In order to ensure attack behaviour is correct,
  As a software developer or security expert,
  I want to run automated attack tests that will pass or fail.

  Scenario: List available attack steps
    Given an attack "nmap" exists
    When I run `gauntlt attack --list`
    Then it should pass with:
      """
      nmap
      """

  Scenario Outline: Run attacks for existing tests
    Given an attack "<name>" exists
    When I run `gauntlt attack --name <name> --host www.google.com`
    Then it should pass
  	Examples:
  	  | name         |
  	  | nmap         |
  	  | cookies      |
  	  | curl         |
  	  | http_methods |
  	  | sslyze       |


  @wip
  Scenario: The attack command is run but there are no available tests to be run
    Given there are no available attacks in the attacks directory
    When I run `gauntlt attack --name <name> --host www.google.com`
    Then it should instruct the user to copy attacks from the examples directory to the attacks directory


