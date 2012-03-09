Feature: Register my interest on the project
  In order to receive updates from this project
  as a subscriber
  I want to register to receive updates from the project

  Scenario: I'm a new interested subscriber
    Given I'm in the splash page
    And I should see the "email" field
    When I fill the form with my email
    And I send the form
    Then I should see "Obrigado pelo interesse, lhe manteremos informado!"
