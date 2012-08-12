Feature: sslyze attack

  Scenario:
    Given an attack "sslyze" exists
    And a file named "sslyze.attack" with:
      """
        Feature: Run sslyze against a target

        Background:
          Given "sslyze" is installed
          And the target hostname is "google.com"

        Scenario: Ensure no anonymous certificates
          When I launch an "sslyze" attack with:
            \"\"\"
              python <sslyze_path> <hostname>:443
            \"\"\"
          Then the output should not contain:
            \"\"\"
            Anon
            \"\"\"

        # Scenario: Make sure that the certificate key size is at least 2048
        #   Given the target hostname is "google.com"
        #   When I launch an "sslyze" attack with:
        #     \"\"\"
        #       python <sslyze_path> <hostname>:443
        #     \"\"\"
        #   Then the key size should be at least 2048
      """
    When I run `gauntlt attack --name sslyze --attack-file sslyze.attack`
    Then it should pass with:
      """
      4 steps (4 passed)
      """
