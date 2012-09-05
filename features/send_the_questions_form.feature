Feature: send the questions form
  In order to 
  As a candidate
  I want to send the questions form
  
  @javascript
  Scenario: When I fill about my plans
    Given there is a candidate with email "candidate@verdadeouconsequencia.org.br"
    And I'm on "this candidate answers page as the candidate"
    When I fill in "Fale mais sobre seus planos, caso seja eleito" with "Estes são meus planos..."
    And I focus out of the field
    And I reload the page
    Then the field "Fale mais sobre seus planos, caso seja eleito" should have content "Estes são meus planos"

  Scenario: when I fill all the form
    Given there is a candidate with email "candidate@verdadeouconsequencia.org.br"
    And I'm on "this candidate answers page as the candidate"
    When I press "Salvar e Enviar questionário"
    Then I should be in "the homepage"
    And an email should be sent to "candidate@verdadeouconsequencia.org.br"
    And an email should be sent to "equipe@verdadeouconsequencia.org.br"
