Feature: Login
  In order to make my questions to candidates
  As a voter
  I want to login

  @omniauth_test
  Scenario: when I'm a new user
    Given I'm on the questions page
    When I click "Entrar"
    Then I should see "Nícolas Iensen"
