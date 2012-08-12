Feature: Cookies attack

  Scenario: Launch cookies attack
    Given an attack "cookies" exists
    And a file named "cookies.attack" with:
      """
      Feature: Evaluate received cookies against expected.

      Background:
        Given "curl" is installed
        And the target hostname is "google.com"

      Scenario: Verify server is returning the cookies expected
        When I launch a "cookies" attack
        Then the following cookies should be received:
          | name | secure | _rest              |
          | PREF | false  | {}                 |
          | NID  | false  | {'HttpOnly': None} |
      """
    When I run `gauntlt attack --name cookies --attack-file cookies.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """