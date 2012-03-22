Feature: Share a question with my friends
  In order to support a question
  As a voter
  I want to share a question with my friends

  @javascript
  Scenario: share on Facebook
    Given there is a question
    And I'm on the questions page
    When I pass over this question
    Then I should see a Facebook share button for this question

  @javascript
  Scenario: share on Twitter
    Given there is a question
    And I'm on the questions page
    When I pass over this question
    Then I should see a Twitter share button for this question
