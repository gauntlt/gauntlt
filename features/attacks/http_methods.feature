Feature: http_methods attack
  Background:
    Given an attack "http_methods" exists

  Scenario: http methods
    Given a file named "http_methods.attack" with:
      """
      Feature: Evaluate responses to various HTTP methods.

      Background:
        Given "curl" is installed
        And the target hostname is "google.com"

      Scenario Outline: Verify server responds correctly to various HTTP methods
        When I launch a "curl" attack with:
          \"\"\"
            curl -i -X <method> <hostname>
          \"\"\"
        Then the output should contain "<response>"
        Examples:
          | method | response                       |
          | delete | Error 405 (Method Not Allowed) |
          | patch  | Error 405 (Method Not Allowed) |
          | trace  | Error 405 (Method Not Allowed) |
          | track  | Error 405 (Method Not Allowed) |
          | bogus  | Error 405 (Method Not Allowed) |
      """
    When I run `gauntlt attack --name http_methods --attack-file http_methods.attack`
    Then it should pass with:
      """
      5 scenarios (5 passed)
      """