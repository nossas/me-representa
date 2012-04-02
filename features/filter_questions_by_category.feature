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

  @javascript
  Scenario: when I filter clicking on the category's link
    Given there is a truth about "Educação" saying "testing education"
    And there is a truth about "Saúde e Drogas" saying "testing drugs :)"
    And I'm on the questions page
    When I click "Saúde e Drogas"
    Then I should not see testing education
    And I should see testing drugs :)
