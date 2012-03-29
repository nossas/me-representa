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
    And I should see Ah... Não tem verdade sobre Saúde e Drogas

  Scenario: when I filter the dares and something is returned
    Given there is a dare about Educação
    And I'm on the questions page
    When I choose "Educação" for "Filtrar consequências por:"
    Then I should see that dare

  Scenario: when I filter the truths and nothing returns
    Given there is a dare about Educação
    And I'm on the questions page
    When I choose "Saúde e Drogas" for "Filtrar consequências por:"
    Then I should not see that dare
    And I should see Ah... Não tem consequência sobre Saúde e Drogas
