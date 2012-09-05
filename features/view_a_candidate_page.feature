Feature: view a candidate page
  In order to learn more about the candidate
  As a visitor
  I want to view a candidate page

  Scenario: when there is a candidate
    Given there is a candidate called "Eduardo Paes"
    When I go to "this candidate page"
    Then I should see Eduardo Paes
