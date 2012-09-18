Feature: View the best candidate to me
  In roder to decide in which candidate I should vote
  As an user
  I want to view the best candidate to me


  @omniauth_test @javascript
  Scenario: When there is a candidate with 100% of matching
    Given I'm logged in
    And there is an unrelated party called "MR"
    And there is a candidate called "Leonardo Eloi" for this party
    And there is a chosen question saying "tem animais de estimação?"
    And this candidate answered "Sim" for this question
    And I'm on "the answers page"
    And I choose "Sim" for the question "tem animais de estimação?"
    And I press "Ver os partidos mais semelhantes comigo"
    And I should be in "the parties page"
    When I click "MR"
    Then I should see Leonardo Eloi
    Then I should see 100%
