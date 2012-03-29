Feature: Filter questions by category
  In order to read only the questions I'm interested
  As a voter
  I want to filter questions by category

  Scenario: when I filter the truths and something is returned
    Given there is a truth about Educação
    And I'm on the questions page
    When I choose "Educação" for "Filtrar verdades por:"
    Then I should see that truth

  Scenario: when I filter the truths and nothing returns
    Given there is a truth about Educação
    And I'm on the questions page
    When I choose "Saúde e Drogas" for "Filtrar verdades por:"
    Then I should not see that truth
    And I should see Nenhuma verdade sobre Saúde e Drogas
