Feature: Manage questions
  In order to keep things clear and make sure users are making good questions
  as and admin
  I want to manage questions

  @omniauth_test @javascript
  Scenario: I'm not logged in 
    Given there is a truth with 15 votes saying Você é a favor da legalização da maconha?
    And I'm on the questions page 
    And there is a truth with 15 votes saying Você é a favor da legalização da maconha?
    Then I should not see "Editar esta pergunta"
    Then I should not see "Excluir esta pergunta"

  @omniauth_test @javascript
  Scenario: I'm logged in as a normal user
    Given there is a truth with 15 votes saying Você é a favor da legalização da maconha?
    And I'm logged in
    And I'm on the questions page 
    Then I should not see "Editar esta pergunta"
    Then I should not see "Excluir esta pergunta"
  
  @omniauth_test @javascript
  Scenario: I'm logged in as a SUPER user ZOMG
    Given there is a truth with 15 votes saying Você é a favor da legalização da maconha?
    And I'm logged in as admin
    And I'm on the questions page 
    Then I should see "Editar esta pergunta"
    Then I should see "Excluir esta pergunta"

