Feature: save my answers
  In order to restore my answering progress
  As a candidate
  I want to save my answers

  Scenario: when I have a valid token to answer the questions
    Given there is a chosen question saying "acredita em OVNI's?"
    And there is a candidate
    And I'm on "this candidate answers page as the candidate"
    And I check "Sim ou Não? Você... acredita em OVNI's?" with "Sim"
    When I press "Salvar minhas respostas"
    Then I should see "Suas perguntas foram salvas, não esqueça de enviar o questionário assim que terminar."
