Feature: nmap attack
  @slow
  Scenario: Launch nmap attack
    Given an attack "nmap" exists
    And a file named "nmap.attack" with:
    """
    Feature: nmap attacks

      Background:
        Given "nmap" is installed
        And the target hostname is "google.com"

      Scenario: Verify server is available on standard web ports
        When I launch an "nmap" attack with:
          \"\"\"
          nmap -p 80,443 <hostname>
          \"\"\"
        Then the output should contain:
          \"\"\"
          80/tcp  open  http
          443/tcp open  https
          \"\"\"

      @slow
      Scenario: Detect OS
        When I launch an "nmap" attack with:
          \"\"\"
          nmap -sV -p80 -PN <hostname>
          \"\"\"
        Then the output should contain:
          \"\"\"
          Service Info: OS: Linux
          \"\"\"
    """
    When I run `gauntlt attack --name nmap --attack-file nmap.attack`
    Then it should pass
    And the output should contain:
      """
      8 steps (8 passed)
      """