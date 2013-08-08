@slow
Feature: web application security scan with arachni
  Background:
    Given an attack "arachni" exists
    And I copy the attack files from the "examples/arachni" folder
    And the following attack files exist:
      | filename     |
      | arachni-xss.attack  |
  Scenario: Check for XSS (Cross Site Scripting) on our site
    When I run `gauntlt arachni-xss.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """
