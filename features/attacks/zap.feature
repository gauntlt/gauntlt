@slow
Feature: Active attacks
  Background:
    Given an attack "zap" exists
    And I copy the attack files from the "examples/zap" folder
    And the following attack files exist:
      | filename       |
      | zap.attack  |

  #Scenario: simple zap attack
  #  When I run `gauntlt zap.attack`
  #  Then it should pass with:
  #    """
  #    4 steps (4 passed)
  #    """
