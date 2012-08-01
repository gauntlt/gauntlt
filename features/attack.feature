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
  	  | sqlmap       |
  	  | sslyze       |

  Scenario: Bad attack name specified
    When I run `gauntlt attack --name thisattackwouldneverexist`
    Then it should fail with:
	"""
	No 'thisattackwouldneverexist' attack found
	"""


