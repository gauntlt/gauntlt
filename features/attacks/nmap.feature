@slow
Feature: nmap attack
  Background:
    Given an attack "nmap" exists
    And I copy the attack files from the "examples/nmap" folder
    And the following attack files exist:
    | filename              |
    | simple.attack         |
    | simple-env-var.attack |
    | os_detection.attack   |
    | tcp_ping_ports.attack |
    | nmap.attack |
    | xml_output.attack     |

  Scenario: Simple nmap attack
    When I run `gauntlt simple.attack`
    Then it should pass with:
      """
      5 steps (5 passed)
      """

  Scenario: Simple nmap using environment variables attack
    When I run `gauntlt simple-env-var.attack`
    Then it should pass with:
      """
      5 steps (5 passed)
      """

  Scenario: OS detection nmap attack
    When I run `gauntlt os_detection.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """

  Scenario: Testing the tcp_ping_ports
    When I run `gauntlt tcp_ping_ports.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """

  Scenario: Handle XML output file
    When I run `gauntlt attack xml_output.attack`
    Then it should pass with:
      """
      5 steps (5 passed)
      """
  Scenario: The full nmap attack
    When I run `gauntlt nmap.attack`
    Then it should pass with:
      """
      17 steps (17 passed)
      """
