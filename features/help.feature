Feature: Display help info

  As a user,
  I want to view contextual help info that tells me what options I need to pass for a certain test

  Scenario: A user runs the help command in the core part of gauntlt
    When I run `gauntlt --help`
    Then I should see a help menu that explains how to invoke gauntlt

  Scenario: A user runs the help command for a certain test
    When I run `gauntlt attack -h -n nmap`
    Then the output should contain:
    """
    Command 'attack':
    """

  Scenario: A user runs gauntlt without any arguments
    When I run `gauntlt`
    Then I should see a help menu that explains how to invoke gauntlt

  Scenario: A user runs the attack command without specifying attack name
    When I run `gauntlt attack`
    Then the output should contain:
    """
    Available attacks:

      cookies
      curl
      http_methods
      nmap
      sslyze

      try: gauntlt attack -n nmap
    """

