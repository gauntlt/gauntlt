@skip-on-jruby
Feature: sqlmap attack

  @slow
  Scenario:
    Given scapegoat is running on port 9292
    And an attack "sqlmap" exists
    And I copy the attack files from the "examples/sqlmap" folder
    And the following attack files exist:
      | filename      |
      | sqlmap.attack |
    When I run `gauntlt`
    Then it should pass with:
      """
      4 steps (4 passed)
      """
    And scapegoat should quit