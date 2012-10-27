Feature: Run attacks by tag

  Background:
    Given a file named "foobar.attack" with:
      """
      Feature: silly attack

        @foo
        Scenario: Foo
          Given the following profile:
            | name | value |
            | foo  | bar   |

        @bar
        Scenario: Bar
          Given the following profile:
            | name | value |
            | bar  | baz   |
      """

  Scenario: Run attack for one tag
    When I run `gauntlt --tags @foo`
    Then it should pass with:
      """
      Feature: silly attack

        @foo
      """
    And the stdout should contain:
      """
      1 scenario (1 passed)
      1 step (1 passed)
      """

  Scenario: Run attack by exluding one tag
    When I run `gauntlt --tags ~@foo`
    Then it should pass with:
      """
      Feature: silly attack

        @bar
      """
    And the stdout should contain:
      """
      1 scenario (1 passed)
      1 step (1 passed)
      """