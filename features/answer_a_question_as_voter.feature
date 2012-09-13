Feature: answer a question as voter
  In order to find my favorite candidate
  As a voter
  I want to answer a question

  @javascript @omniauth_test
  Scenario: when I am logged in
    Given there is a chosen question saying "acredita em OVNI's?"
    And I'm logged in
    And I'm on "the answers page"
    When I choose "Sim" for the question "Sim ou Não? Você... acredita em OVNI's?"
    Then a new answer should be created to me
