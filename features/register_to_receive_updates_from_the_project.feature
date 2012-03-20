Feature: Register to receive updates from the project
  In order to receive updates from this project
  As a subscriber
  I want to register to receive updates from the project

  Scenario: I'm a new interested subscriber
    When I send the subscriber form with my email
    Then I should see Obrigado pelo interesse, lhe manteremos informado!
