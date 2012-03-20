Feature: Login
  In order to make my questions to candidates
  As a voter
  I want to login

  @omniauth_test
  Scenario: when I choose Meu Rio provider
    Given I'm on the questions page
    When I click "MeuRio"
    Then I should see "Nícolas Iensen"

  @omniauth_test
  Scenario: when I choose Facebook provider
    Given I'm on the questions page
    When I click "Facebook"
    Then I should see "Nícolas Iensen"

  @omniauth_test
  Scenario: when I want to log out
    Given I'm logged in
    And I'm on the questions page
    When I click "Sair"
    Then I should not see "Nícolas Iensen"
    And I should see "Entre com a sua conta do MeuRio ou do Facebook"
