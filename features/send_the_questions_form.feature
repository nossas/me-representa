Feature: send the questions form
  In order to 
  As a candidate
  I want to send the questions form

  Scenario: when I fill all the form
    Given there is a candidate with email "candidate@verdadeouconsequencia.org.br"
    And I'm on "this candidate answers page as the candidate"
    When I press "Salvar e Enviar questionário"
    Then I should be in "the homepage"
    And an email should be sent to "candidate@verdadeouconsequencia.org.br"
    And an email should be sent to "equipe@verdadeouconsequencia.org.br"
