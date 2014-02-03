@scapegoat
Feature: sqlmap attack

  @slow
  Scenario:
    Given an attack "sqlmap" exists
    And scapegoat is running on port 9292
    And I copy the attack files from the "examples/sqlmap" folder
    And the following attack files exist:
      | filename      |
      | sqlmap.attack |
    When I run `gauntlt`
    Then it should pass with:
      """
      5 steps (5 passed)
      """
    And scapegoat should quit