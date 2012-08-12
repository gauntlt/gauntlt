Feature: curl attack
  Background:
    Given an attack "curl" exists

  Scenario: curl attack
    Given a file named "curl.attack" with:
      """
      Feature: Launch curl attack

      Background:
        Given "curl" is installed
        And the target hostname is "google.com"

      Scenario: Verify a 301 is received from a curl
        When I launch a "curl" attack
        Then the response code should be "301"
      """
    When I run `gauntlt attack --name curl --attack-file curl.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """