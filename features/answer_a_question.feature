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

  Scenario: when I haven't a valid token to answer the questions
    Given there is a chosen question saying "acredita em OVNI's?"
    And there is a candidate
    When I go to "this candidate answers page without token"
    Then I should be in "the homepage"
