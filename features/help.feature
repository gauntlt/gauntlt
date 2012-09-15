Feature: Display help info

  As a user of gauntlt,
  I want contextual help info,
  In order to learn the options required by an attack

  Scenario: Global help
    When I run `gauntlt --help`
    Then the output should contain:
      """
      gauntlt is a ruggedization framework

      Usage:
             gauntlt <path>+
      """