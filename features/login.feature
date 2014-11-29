Feature: Initial experience
  As a user I want a helpful and simple initial
  experience with the app. I should be able to get help
  and login to an existing WordPress site.

  @info @reinstall
  Scenario: Obtaining more information
    Given I am on the first experience screen
    And I choose to get more information
    Then I am taking to the information screen

  @create_account
  Scenario: Create new account
    Given I am about to login
    Then I am able to create an account

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

