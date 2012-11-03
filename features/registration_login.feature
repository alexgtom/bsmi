Feature: A mentor teacher can signup and login to the web application

  As a mentor teacher
  I want to register an account
  So that I can use the webapp

Scenario: add mentor teacher to database
  Given I am on the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "myemail@nowhere.com"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be located at "/user"
  And I should see "myemail@nowhere.com"

Scenario: edit mentor teacher's profile
  Given I am signed up
  Given I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/user"
  When  I follow "Edit Profile"
  Then I should be located at "/users/1/edit"
  And the "user_name" field should contain "Sangyoon Park"
  And the "user_address" field should contain "346 soda UC Berkeley, United States"
  And the "user_phone_number" field should contain "123-456-7890"
  And the "user_email" field should contain "myemail@nowhere.com"
  And the "user_password" field should not contain "1234"
  Then I fill in "user_name" with "Edited User"
  And I fill in "user_address" with "people's park"
  And I fill in "user_phone_number" with "111-111-1111"
  And I fill in "user_email" with "changed@email.com"
  And I press "Update"
  Then I should be located at "/users/1"
  Then I follow "Edit Profile"
  Then I should be located at "/users/1/edit"
  And the "user_name" field should contain "Edited User"
  And the "user_address" field should contain "people's park"
  And the "user_phone_number" field should contain "111-111-1111"
  And the "user_email" field should contain "changed@email.com"
  And the "user_password" field should not contain "1234"

Scenario: can't register if we enter bad email address
  Given I am on the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "i dont have email???"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be located at "/users"
  And  I should see "Email should look like an email address."

Scenario: can't register password and confirmation do not match
  Given I am on the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "mail@mail.com"
  And  I fill in "Password" with "123"
  And  I fill in "Password confirmation" with "111"
  And  I press "Register"
  Then I should be located at "/users"
  And  I should see "Password doesn't match confirmation"

Scenario: Log out of the web application
  Given I am on the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "myemail@nowhere.com"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be located at "/user"
  And I should see "myemail@nowhere.com"
  And I follow "Logout"
  Then I should be located at "/signup"


