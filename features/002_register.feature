Feature: Register
  As a user
  I want to user the sign up feature 
  So that I can be a member

  Background: Setting env
    Given I prepare the state of the app as logout user
    Given I am in the register page

    # Scenario outline is not implemented in App Center!
    # Scenario Outline: Obtaining more information
    #   When I enter <First Name> <Last Name> <Email> and <Password> for registration
    #   Then I should see the <Result>

    #   Examples:
    #     | First Name | Last Name | Email              | Password | Result  |
    #     | John       | Doe       | xjohndoe           | Pass1234 | Fail    |
    #     | John       | Doe       | xjohndoe@gmail.com | Pass1234 | Fail    |
    #     | John       | Doe       | NewEmail           | Pass1234 | Success |

    Scenario: Register Failed - email format
      When I enter 'John' 'Doe' 'xjohndoe' and 'PasPasssss' for registration
      Then I should see the 'Fail'

    Scenario: Register Failed - already member
      When I enter 'John' 'Doe' 'xxjohndoe@gmail.com' and 'PasPasssss' for registration
      Then I should see the 'Fail'

    Scenario: Register Success
      When I enter 'John' 'Doe' 'NewEmail' and 'PasPasssss' for registration
      Then I should see the 'Success'

