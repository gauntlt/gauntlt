Feature: sqlmap attack

  @slow
  Scenario:
    Given an attack "sqlmap" exists
    And I copy the attack files from the "examples/sqlmap" folder
    And the following attack files exist:
      | filename      |
      | sqlmap.attack |
    When I run `gauntlt`
    Then it should pass with:
      """
      6 steps (6 passed)
      """
