@slow
Feature: Active attacks
  Background:
    Given an attack "owasp-zap" exists
    And I copy the attack files from the "examples/owasp-zap" folder
    And the following attack files exist:
      | filename       |
      | owasp-zap.attack  |

  Scenario: owasp-zap attack
    When I run `gauntlt owasp-zap.attack`
    Then it should pass with:
      """
      1 steps (1 passed)
      """
