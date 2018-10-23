Feature: Register
  As a user
  I want to user the sign up feature 
  So that I can be a member

  Background: Setting env
    Given I prepare the state of the app as logout user
    Given I am in the register page

    # Scenario Outline: Obtaining more information
    #   When I enter <First Name> <Last Name> <Email> and <Password> for registration
    #   Then I should see the <Result>

    #   Examples:
    #     | First Name | Last Name | Email              | Password | Result  |
    #     | John       | Doe       | xjohndoe           | Pass1234 | Fail    |
    #     | John       | Doe       | xjohndoe@gmail.com | Pass1234 | Fail    |
    #     | John       | Doe       | NewEmail           | Pass1234 | Success |

    Scenario: Fail login
      When I enter "John" "Doe" "xjohndoe" and "Pass1234" for registration
      Then I should see the "Fail"

    Scenario: Fail login
      When I enter "John" "Doe" "xjohndoe@gmail.com" and "Pass1234" for registration
      Then I should see the "Fail"

    Scenario: Success login
      When I enter "John" "Doe" "NewEmail" and "Pass1234" for registration
      Then I should see the "Success"

