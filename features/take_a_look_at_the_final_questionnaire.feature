Feature: take a look at the final questionnaire
  In order to know the most relevant questions for the cariocas
  As a visitor
  I want to take a look at the final questionnaire

  Scenario: when there is a choosen question
    Given there is a choosen question saying "é favorável ao PL conhecido como ATO MÉDICO?"
    When I go to "the homepage"
    Then I should see é favorável ao PL conhecido como ATO MÉDICO?
