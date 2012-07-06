Feature: Edit a question from an user
  In order to keep things clear on the form that will be sent to candidates
  As an admin
  I want to edit a question

  @omniauth_test @javascript
  Scenario: I
    Given there is a truth with 15 votes saying Você é a favor da legalização da maconha?
    And I'm logged in as admin
    And I'm on the questions page
    And I click "Editar esta pergunta"
    And I should see Edição
    And I should see question's text field
    And I should see question's category field
    And I fill in "question[text]" with "Atualizando a questão de outrem"
    When I press "Atualizar"
    Then I should see Atualizando a questão de outrem
