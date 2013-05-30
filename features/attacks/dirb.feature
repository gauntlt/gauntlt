@slow
Feature: dirb scan
  Background:
    Given an attack "dirb" exists
    And I copy the attack files from the "examples/dirb" folder
    And the following attack files exist:
      | filename     |
      | dirb.attack  |
    When I run `gauntlt`
    Then it should pass with:
      """
      4 steps (4 passed)
      """
