Feature: Login
  In order to make my questions to candidates
  As a voter
  I want to login

  @omniauth_test
  Scenario: when I choose Meu Rio provider
    Given I'm on the questions page
    When I click "Entrar via Meu Rio"
    Then I should see "Nícolas Iensen"

  @omniauth_test
  Scenario: when I choose Facebook provider
    Given I'm on the questions page
    When I click "Entrar via Facebook"
    Then I should see "Nícolas Iensen"
