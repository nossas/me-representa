Feature: answer a question
  In order to help people choose somebody to vote
  As a candidate
  I want to answer a question

  @javascript
  Scenario: when I have a valid token to answer the questions
    Given there is a chosen question saying "acredita em OVNI's?"
    And there is a candidate
    And I'm on "this candidate answers page as the candidate"
    When I choose "Sim" for the question "Sim ou Não? Você... acredita em OVNI's?"
    Then a new answer should be created to this candidate
    And I should be assigned to the group 1

  Scenario: when I haven't a valid token to answer the questions
    Given there is a chosen question saying "acredita em OVNI's?"
    And there is a candidate
    When I go to "this candidate answers page without token"
    Then I should be in "the homepage"

  Scenario: when three candidates reach the questions page
    Given there is a candidate
    When I go to "this candidate answers page as the candidate"
    Then I should be assigned to the group 1
    Given there is a candidate
    When I go to "this candidate answers page as the candidate"
    Then I should be assigned to the group 2
    Given there is a candidate
    When I go to "this candidate answers page as the candidate"
    Then I should be assigned to the group 1
  
  Scenario: when the same candidate reaches the questions page twice
    Given there is a candidate
    And I go to "this candidate answers page as the candidate"
    When I go to "this candidate answers page as the candidate"
    Then I should be assigned to the group 1
