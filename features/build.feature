Feature: Ability to build the gem gauntlt, install it and release to rubygems

  Scenario: Build the gem 
    Given that I have not installed any dependency gems 
    When I run the bundle command
    Then it should build a gem

  Scenario: Upload the gauntlt gem to ruby gems 
    Given that I have a bundled gem  
    When I run the command to upload to ruby gems
    Then it should add the new gem to ruby gems
