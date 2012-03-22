Feature: Vote for a question
  In order to support a question
  As a voter
  I want to vote for a question

  @javascript
  Scenario: I have not voted yet
    Given there is a question
    And I'm on the questions page
    When I press "Votar"
    Then I should see Valeu por votar!

