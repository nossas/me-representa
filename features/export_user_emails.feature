Feature: Export user emails
  In ordert to make good looking reports
  as an admin
  I want to be able to export user emails in csv format

  @omniauth_test
  Scenario: I'm logged user but not an admin
    Given I'm in the home page
    When I click "Facebook"
    Then I should not see Exportar Usuários

  @omniauth_test
  Scenario: I'm logged user but I am an admin
    Given I'm in the home page
    And I'm logged in as admin
    When I click "Facebook"
    Then I should see Exportar Usuários
