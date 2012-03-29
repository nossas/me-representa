Feature: Filter questions by category
  In order to read only the questions I'm interested
  As a voter
  I want to filter questions by category

  @javascript
  Scenario: when I filter truths and something is returned
    Given there is a truth about Educação
    And I'm on the questions page
    When I filter truths by "Educação"
    Then I should see that truth

  @javascript
  Scenario: when I filter truths and nothing returns
    Given there is a truth about Educação
    And I'm on the questions page
    When I filter truths by "Saúde e Drogas"
    Then I should not see that truth
    And I should see Ah... Não tem verdade sobre Saúde e Drogas

  @javascript
  Scenario: when I filter dares and something is returned
    Given there is a dare about Educação
    And I'm on the questions page
    When I filter dares by "Educação"
    Then I should see that dare

  @javascript
  Scenario: when I filter dares and nothing returns
    Given there is a dare about Educação
    And I'm on the questions page
    When I filter dares by "Saúde e Drogas"
    Then I should not see that dare
    And I should see Ah... Não tem consequência sobre Saúde e Drogas
