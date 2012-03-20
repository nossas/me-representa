Feature: Share a question with my friends
  In order to support a question
  As a voter
  I want to share a question with my friends

  Scenario: share on Facebook
    Given there is a question
    When I go to the questions page
    Then I should see a Facebook share button for this question

  Scenario: share on Twitter
    Given there is a question
    When I go to the questions page
    Then I should see a Twitter share button for this question
