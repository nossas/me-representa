Feature: Post my own question
  In order to contribute to the political quiz
  As a questioner
  I want to post my own question

  @omniauth_test @javascript
  Scenario: when I'm logged in
    Given I'm logged in
    And I go to the questions page
    And I fill in "Sr. candidato é verdade que..." with "você é a favor da liberação da maconha?"
    And I choose "Saúde e Drogas" for "Assunto"
    And I press "Pré-visualizar"
    When I press "Publicar"
    Then I should see Nícolas Iensen quer saber sobre Saúde e Drogas:
    And I should see Sr. candidato é verdade que você é a favor da liberação da maconha?
    And I should see some share buttons for my question
