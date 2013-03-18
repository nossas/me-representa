Feature: Give a star to a candidate
  In order to remember my favorite candidates
  as an user
  I want to be able to make a candidate my favorite giving him a star

  @omniauth_test @javascript
  Scenario: When I already have a mobile_phone setted up
    Given I'm logged in
    And there is a party called "MR" united to "Por um Rio Melhor"
    And there is a candidate called "Leonardo Eloi" for this party
    And there is a chosen question saying "tem animais de estimação?"
    And this candidate answered "Sim" for this question
    And I'm on "the answers page"
    And I choose "Sim" for the question "tem animais de estimação?"
    When I press "Ver resultado"
    Then I should be in "the parties page"
    When I click "Por um Rio Melhor"
    Then I should see LEONARDO ELOI
    When I check "user[candidate_id]" from the like form
    Then I should have a favorite candidate

  @omniauth_test @javascript
  Scenario: When I do not have a mobile_phone setted up
    Given I'm logged in
    And there is a party called "MR" united to "Por um Rio Melhor"
    And there is a candidate called "Leonardo Eloi" for this party
    And there is a chosen question saying "tem animais de estimação?"
    And this candidate answered "Sim" for this question
    And I'm on "the answers page"
    And I choose "Sim" for the question "tem animais de estimação?"
    When I press "Ver resultado"
    Then I should be in "the parties page"
    When I click "Por um Rio Melhor"
    Then I should see LEONARDO ELOI
    And I should not see QUER QUE O MEU RIO REFRESQUE SUA MEMÓRIA NO DIA DA ELEIÇÃO?
    When I check "user[candidate_id]" from the like form
    Then I should see QUER QUE O MEU RIO REFRESQUE SUA MEMÓRIA NO DIA DA ELEIÇÃO?
    And I should have a favorite candidate
