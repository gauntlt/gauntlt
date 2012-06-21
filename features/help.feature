Feature: As a user I want to have a contextual help menu that tells me what options I need to pass for a certain test

  Background:
    Given I have gauntlt installed

  Scenario: A user runs the help command in the core part of gauntlt
    When I run `gauntlt help`
    Then I should see a help menu that explains how to invoke gauntlt

  Scenario: A user runs the help command for a certain test
    When I run `gauntlt help --test nmap`
    Then the output should contain:
    """
    ex: gauntlt --test nmap --host <hostname> --port <port>
    --host <hostname> should be a single IP address or domain name
    --port <port> can be single port or range of ports
    """

  Scenario: A user runs gauntlt without any arguments
    When I run `gauntlt`
    Then the output should contain:
    """
    You must specify the test you wish to run along with the correct number of arguments.
    try: gauntlt --test nmap --hostname example.com
    """

  Scenario: A user runs gauntlt without the correct number of arguments
    When I run `gauntlt --test nmap`
    Then the output should contain:
    """
    Missing Arguments.
    For the test you are trying to run you need to specify additional arguments.  To know what arguments you need to run, try running gauntlt help --test nmap
    """

     
      
