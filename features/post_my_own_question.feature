Feature: Post my own question
  In order to contribute to the political quiz
  As a questioner
  I want to post my own question

  @omniauth_test @javascript
  Scenario: when I post a truth
    Given I'm logged in
    And I go to the questions page
    And I fill in "Sr. candidato é verdade que..." with "você é a favor da liberação da maconha?"
    And I choose "Saúde e Drogas" for "Assunto"
    And I press "Pré-visualizar"
    When I press "Publicar"
    Then I should see Nícolas Iensen quer saber sobre Saúde e Drogas
    And I should see Sr(a). candidato, é verdade que você é a favor da liberação da maconha?
    And I should see some share buttons for my truth

  @omniauth_test @javascript
  Scenario: when I post a dare
    Given I'm logged in
    And I go to the questions page
    And I fill in "Sr. candidato você deverá..." with "instalar 10 novas paradas de onibus na Glória"
    And I choose "Saúde e Drogas" for "Assunto"
    And I press "Pré-visualizar"
    When I press "Publicar"
    Then I should see Nícolas Iensen lançou uma demanda para Saúde e Drogas
    And I should see Sr(a). candidato, você deverá instalar 10 novas paradas de onibus na Glória
    And I should see some share buttons for my dare
