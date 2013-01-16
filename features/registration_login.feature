Feature: A user can signup and login to the web application

  As a user(student, mentor teacher, cal faculty)
  I want to register an account
  So that I can use the webapp

Background: invites in database
  Given we are currently in a semester

  Given the following invites exist:
  | owner_type | email                  | invite_code                              | first_name | last_name |
  | Student    | myemail@nowhere.com    | aa10df161da4c011d507dea384aa2d03cbc2e5ba | Sangyoon   | Park      |

Scenario: create a student to database
  Given I am invited and on the signup page
  And  I fill in "First name" with "Sangyoon"
  And  I fill in "Last name" with "Park"
  And  I fill in "Street address" with "346 soda UC Berkeley"
  And  I fill in "City" with "Berkeley"
  And  I fill in "State" with "CA"
  And  I fill in "Zipcode" with "94000"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be located at "/users/1"
  And I should see "myemail@nowhere.com"

Scenario: I can't log in if I'm not registered
  Given I am signed up as a student advisor
  Given I am on the login page
  And I fill in "Email" with "wrong_email@email.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/user_sessions"
  And I should see "Email is not valid"

Scenario: edit mentor teacher's profile
  Given I am signed up as a student advisor
  Given I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/settings"
  When  I follow "Edit Profile"
  Then I should be located at "/users/1/edit"
  And the "user_first_name" field should contain "Sangyoon"
  And the "user_last_name" field should contain "Park"
  And the "user_street_address" field should contain "346 soda UC Berkeley"
  And the "user_city" field should contain "Berkeley"
  And the "user_state" field should contain "CA"
  And the "user_zipcode" field should contain "94000"
  And the "user_phone_number" field should contain "123-456-7890"
  And the "user_email" field should contain "myemail@nowhere.com"
  And the "user_password" field should not contain "1234"
  Then I fill in "user_first_name" with "Edited User"
  And I fill in "user_street_address" with "people's park"
  And I fill in "user_phone_number" with "111-111-1111"
  And I fill in "user_email" with "changed@email.com"
  And I press "Update"
  Then I should be located at "/users/1"
  Then I follow "Edit Profile"
  Then I should be located at "/users/1/edit"
  And the "user_first_name" field should contain "Edited User"
  And the "user_street_address" field should contain "people's park"
  And the "user_phone_number" field should contain "111-111-1111"
  And the "user_email" field should contain "changed@email.com"
  And the "user_password" field should not contain "1234"

Scenario: can't register if I am not invited
  Given I am on the signup page
  And  I fill in "First name" with "Sangyoon"
  And  I fill in "Last name" with "Park"
  And  I fill in "Street address" with "346 soda UC Berkeley"
  And  I fill in "City" with "Berkeley"
  And  I fill in "State" with "CA"
  And  I fill in "Zipcode" with "94000"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be located at "/users"
  And  I should see "There was a problem creating you"

Scenario: can't register password and confirmation do not match
  Given I am invited and on the signup page
  And  I fill in "First name" with "Sangyoon"
  And  I fill in "Last name" with "Park"
  And  I fill in "Street address" with "346 soda UC Berkeley"
  And  I fill in "City" with "Berkeley"
  And  I fill in "State" with "CA"
  And  I fill in "Zipcode" with "94000"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Password" with "123"
  And  I fill in "Password confirmation" with "111"
  And  I press "Register"
  Then I should be located at "/users"
  And  I should see "Password doesn't match confirmation"

Scenario: Log out of the web application
  Given I am signed up as a student advisor
  Given I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/settings"
  And I should see "myemail@nowhere.com"
  And I follow "Logout"
  Then I should be located at "/"

Scenario: I can't signup/login when i'm logged in
  Given I am signed up as a student advisor
  Given I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/settings"
  And I am on the signup page
  Then I should see "You must be logged out to access this page"
  And I am on the login page
  Then I should see "You must be logged out to access this page"

Scenario: I can't logout when i'm not logged in
  Given I am on the logout page
  Then I should see "You must be logged in to access this page"

