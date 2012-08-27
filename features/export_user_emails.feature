Feature: Export user emails
  In ordert to make good looking reports
  as an admin
  I want to be able to export user emails in csv format

  @omniauth_test @javascript
  Scenario: I'm logged user but not an admin
    Given I'm logged in
    When I open the user menu
    Then I should not see Exportar todos os usuários

  @omniauth_test @javascript
  Scenario: I'm logged user but I am an admin
    Given I'm logged in as admin
    When I open the user menu
    Then I should see Exportar todos os usuários
