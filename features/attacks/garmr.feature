@scapegoat
Feature: Garmr scan
  Background:
    Given an attack "garmr" exists
    And I copy the attack files from the "examples/garmr" folder
    And the following attack files exist:
      | filename      |
      | garmr.attack  |
    When I run `gauntlt`
    Then it should pass with:
      """
      6 steps (6 passed)
      """
    And scapegoat should quit
