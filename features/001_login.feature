Feature: Login
  As a user 
  I want to login to system
  So that I can use the applation

  Background: Setting env
    Given I prepare the state of the app as logout user
    Given I am in the login page

	  Scenario: Login to system success
	    When I fill in "Email" as "testjohndoe@gmail.com"
	    And I fill in "Password" as "Pass1234"
	    And I touch the log-in button 
	    Then I should see "Products" text
