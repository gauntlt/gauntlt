Feature: Help users get started with documentation  

  Scenario: Opening the main project documentation
    Given that I have installed the gauntlt gem
    When I run the gauntlt help command
    Then it should have a help menu 

  Scenario: View the project README
    Given that I have forked gauntlt  
    When I read the README in the root
    Then it should have instructions to build the gem and how to add extensions to gauntlt
