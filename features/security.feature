Feature: Security-related step definitions

  In order to specify security priorities and automate verification of security,
  As a software developer or security expert,
  I want to have step definitions related to security

  Scenario: Basic security-related steps
    Given I have a secure web app with cucumber and gauntlt
    And I write to "features/f.feature" with:
      """
      Feature: Secure pages
      
      Scenario: Purchase page
        Given I am on the purchase page
        Then the page should be highly secure against cross-site scripting
        And the page should secure all communications

      Scenario: Login page
        Given I am on the login page
        Then the page should be highly secure against brute force attacks
        And the page should not reveal valid usernames
      """
    When I run `bundle exec rake cucumber`
    Then it should pass with:
      """
      2 scenarios (2 passed)
      6 steps (6 passed)
      """