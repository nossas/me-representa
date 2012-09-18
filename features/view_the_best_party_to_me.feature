Feature: View the best party to me
  In order to decide in which party I should vote
  As a visitor
  I want to view the best party to me

  @omniauth_test @javascript
  Scenario: when there is a party with 100% of matching
    Given I'm logged in
    And there is an unrelated party called "MR"
    And there is a candidate for this party
    And there is a chosen question saying "tem animais de estimação?"
    And this candidate answered "Sim" for this question
    And I'm on "the answers page"
    And I choose "Sim" for the question "tem animais de estimação?"
    When I press "Ver os partidos mais semelhantes comigo"
    Then I should be in "the parties page"
    And I should see MR
    And I should see 100%

  @omniauth_test @javascript
  Scenario: when there is an union with 100% of matching
    Given I'm logged in
    And there is a party called "MR" united to "Por um Rio Melhor"
    And there is a candidate for this party
    And there is a chosen question saying "tem animais de estimação?"
    And this candidate answered "Sim" for this question
    And I'm on "the answers page"
    And I choose "Sim" for the question "tem animais de estimação?"
    When I press "Ver os partidos mais semelhantes comigo"
    Then I should be in "the parties page"
    And I should see Por um Rio Melhor (coligação)
    And I should see 100%
    And I should not see MR
