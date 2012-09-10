Feature: Receive link to participate
  In order to participate in the VoC survey
  As a candidate
  I want to be able to participate with my cellphone number or by email

  @javascript
  Scenario: When I haven't my cellphone and my email registered
    Given I'm in the home page
    When I click "É candidato a vereador do Rio e ainda não recebeu o questionário? Clique aqui para solicitar o reenvio!"
    And I should see Insira seus dados para solicitar o reenvio de sua url única
    And I fill in "Insira seu e-mail" with "tester@tester.com"
    And I fill in "Insira seu celular" with "5555555555"
    Then I should see Infelizmente, seu cadastro não consta em nossa base de dados
