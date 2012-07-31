Feature: Verify the attack behaviour is correct

  In order to ensure attack behaviour is correct,
  As a software developer or security expert,
  I want to run automated attacks that will pass or fail.

  Scenario: List available attack steps
    Given an attack "nmap" exists
    When I run `gauntlt attack --list`
    Then it should pass with:
      """
      nmap
      """

  Scenario: Run attack for existing tests
    Given an attack "nmap" exists
    And a file named "nmap.attack" with:
    """
    Feature: my nmap attacks
      Scenario: nmap attack works
        Given "nmap" is installed
        And the target hostname is "google.com"
        When I launch an "nmap" attack with:
          \"\"\"
          nmap -p 80,443 <hostname>
          \"\"\"
        Then the output should contain:
          \"\"\"
          80/tcp  open  http
          443/tcp open  https
          \"\"\"
    """
    When I run `gauntlt attack --name nmap --attack-file nmap.attack`
    Then it should pass

  Scenario: Bad attack name specified
    When I run `gauntlt attack --name thisattackwouldneverexist`
    Then it should fail with:
    """
    Must specify name and attack-file
    """

  Scenario: No attack name specified
    When I run `gauntlt attack --attack-file thisattackwouldneverexist`
    Then it should fail with:
    """
    Must specify name and attack-file
    """

  Scenario: Bad attack file specified
    When I run `gauntlt attack --name nmap --attack-file thisattackwouldneverexist`
    Then it should fail with:
    """
    No 'thisattackwouldneverexist' attack found
    """

  Scenario: No attack file specified
    When I run `gauntlt attack --name nmap`
    Then it should fail with:
    """
    Must specify name and attack-file
    """
