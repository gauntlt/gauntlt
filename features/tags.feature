Feature: Run attacks by tag

  Background:
    Given an attack "nmap" exists
    And a file named "nmap.attack" with:
    """
    Feature: my nmap attacks

      @foo
      Scenario: Foo
        Given the target hostname is "foo"

      @bar
      Scenario: Bar
        Given the target hostname is "bar"
    """

  Scenario: Run attack for one tag
    When I run `gauntlt --tags @foo`
    Then it should pass with:
    """
    Feature: my nmap attacks

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
    Feature: my nmap attacks

      @bar
    """
    And the stdout should contain:
    """
    1 scenario (1 passed)
    1 step (1 passed)
    """