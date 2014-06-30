Feature: Login

  @invalid
  Scenario: Add site - Invalid login
    Given I am about to login
    When I enter invalid credentials
    Then I am presented with an error message to correct credentials

  @valid
  Scenario: Add site
    Given I am about to login
    When I enter valid credentials
    Then I am successfully authenticated
    And I can see posts for the site

