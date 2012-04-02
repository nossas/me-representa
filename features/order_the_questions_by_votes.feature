Feature: Order the questions by votes
  In order to find out the most relevant questions
  As a voter
  I want to order the questions by votes

  @javascript
  Scenario: 
    Given there is a truth with 100 votes saying você é a favor da linha 4 original do Metrô?
    And there is a truth with 1000 votes saying o senhor é a favor da pena de morte?
    And I'm on the questions page
    When I order truths by votes
    Then I should see "o senhor é a favor da pena de morte?" above "você é a favor da linha 4 original do Metrô?"
