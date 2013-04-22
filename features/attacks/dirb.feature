@scapegoat
Feature: dirb scan
  Background:
    Given an attack "dirb" exists
    And scapegoat is running on port 9292
    And I copy the attack files from the "examples/dirb" folder
    And the following attack files exist:
      | filename      |
      | dirb.attack  |
    When I run `gauntlt`
    Then it should pass with:
      """
      1 step (1 passed)
      """
    And scapegoat should quit
