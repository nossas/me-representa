Feature: save my answers
  In order to restore my answering progress
  As a candidate
  I want to save my answers

  @javascript
  Scenario: when I have a valid token to answer the questions
    Given there is a chosen question saying "acredita em OVNI's?"
    And there is a candidate
    And I'm on "this candidate answers page as the candidate"
    When I choose "Sim" for the question "Sim ou Não? Você... acredita em OVNI's?"
    Then a new answer should be created to this candidate
