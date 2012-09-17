Feature: sslyze attack

  @slow
  Scenario:
    Given an attack "sslyze" exists
    And I copy the attack files from the "examples/sslyze" folder
    And the following attack files exist:
      | filename      |
      | sslyze.attack |
    When I run `gauntlt`
    Then it should pass with:
      """
      4 steps (4 passed)
      """
