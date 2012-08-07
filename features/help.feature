Feature: Display help info

  As a user of gauntlt,
  I want contextual help info,
  In order to learn the options required by an attack

  Scenario: Global help
    When I run `gauntlt --help`
    Then the output should contain:
      """
      usage: gauntlt attack [<args>]
      """

  Scenario: Attack help
    When I run `gauntlt attack -h -n nmap`
    Then the output should contain:
      """
      usage: gauntlt attack -n [attack-name] -a [attack-file]
      """

  Scenario: A user runs gauntlt without any arguments
    When I run `gauntlt`
    Then the output should contain:
      """
      Try --help for help
      """

  Scenario: A user runs the attack command without specifying attack name
    When I run `gauntlt attack`
    Then the output should contain:
      """
      Available attacks:

        cookies
        curl
        http_methods
        nmap
        sqlmap
        sslyze

        try: gauntlt attack -n nmap
      """