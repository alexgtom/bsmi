Feature: search for movies by director

  As a mentor teacher
  I want to register an account
  So that I can use the webapp

Scenario: add mentor teacher to database
  When I go to the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "myemail@nowhere.com"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be on the user page
  And the content of "Email" should be "myemail@nowhere.com"
  And the content of "Login count" should be "1"

Scenario: viewing edit page of mentor teacher's profile
  Given I am on the user page
  When  I follow "Edit Profile"
  Then  I should be on the edit page
  And   I should see "Sangyoon Park"
  And   I should see "346 soda UC Berkeley, United States"
  And   I should see "123-456-7890"
  And   I should see "myemail@nowhere.com"
  But   I should not see "1234"  

Scenario: using signed up email and password to log in
  Given I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be on the user page
  And the content of "Email" should be "myemail@nowhere.com"

Scenario: can't register if we enter bad email address
  When I go to the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "i dont have email???"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be on the user page
  And  I should see "Email should look like an email address."

Scenario: can't register password and confirmation do not match
  When I go to the signup page
  And  I fill in "Name" with "Sangyoon Park"
  And  I fill in "Address" with "346 soda UC Berkeley, United States"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "mail@mail.com"
  And  I fill in "Password" with "123"
  And  I fill in "Password confirmation" with "111"
  And  I press "Register"
  Then I should be on the user page
  And  I should see "Password is too short"
  And  I should see "Password doesn't match confirmation"
  And  I should see "Password confirmation is too short"

Scenario: Log out of the web application
  Given I am on the login page
  Then I fill in "Email" with "myemail@nowhere.com"
  And  I fill in "Password" with "1234"
  And  I press "Login"
  Then I should be on the user page
  And  I follow "Logout"
  And  I should be on the login page




