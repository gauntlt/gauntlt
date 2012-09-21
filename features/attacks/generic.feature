Feature: Generic
  Background:
    Given an attack "generic" exists
    And I copy the attack files from the "examples/generic" folder
    And the following attack files exist:
      | filename       |
      | generic.attack |

  Scenario: generic attack
    When I run `gauntlt generic.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """