Feature: sqlmap attack

  Scenario:
    Given an attack "sqlmap" exists
    And a file named "sqlmap.attack" with:
      """
        Feature: Run sqlmap against a target

        Background:
          Given "sqlmap" is installed
      """
    When I run `gauntlt`
    Then it should pass with:
      """
      1 step (1 passed)
      """
