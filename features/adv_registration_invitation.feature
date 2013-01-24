Feature: A student advisor can invite/add/edit/delete a user

  As a student advisor
  I want to invite/add/edit/delete users
  So that I can manage the webapp

Background:
  Given we are currently in a semester

Scenario: I can't access invite page without login as an advisor
  Given I am a mentor teacher
  And I go to /invites
  Then I should not be located at "/invites"
  And I should see "You don't have permission to access that page"

Scenario: I can't access add user page without login as an advisor
  Given I am a mentor teacher
  And I go to /user/adv_new
  Then I should not be located at "/user/adv_new"
  And I should see "You don't have permission to access that page"

Scenario: I can invite a person
  Given I am signed up as a student advisor
  And I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/settings"
  When I go to /invites
  Then I should be located at "/invites"
  And I follow "New Invite"
  Then I should be located at "/invites/new"
  And I select "Student" from "Owner type"
  And I fill in "First name" with "sangyoon"
  And I fill in "Last name" with "park"
  And I fill in "Email" with "sangp@email.com"
  And I press "Save"
  Then I should be located at "/invites"
  And I should see "Invite was successfully created"
  And I should see "sangp@email.com"
#  And I should see "[Invite]"
#  When I follow "[Invite]"
#  Then I should see "Invite sent to sangp@email.com"
#  And I should see "Invited"

Scenario: I can't invite a blank email
  Given I am signed up as a student advisor
  And I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/settings"
  When I go to /invites
  Then I should be located at "/invites"
  And I follow "New Invite"
  Then I should be located at "/invites/new"
  And I press "Save"
  Then I should be located at "/invites"
  And I should see "There was a problem inviting a user"
  And I should see "Email can't be blank"

Scenario: I can add/edit/delete a user
  Given I am signed up as a student advisor
  And I am on the login page
  And I fill in "Email" with "myemail@nowhere.com"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/settings"
  When I go to /user/adv_new
  Then I should see "Add an account"
  And I select "Student" from "Owner type"
  And  I fill in "First name" with "testuser1"
  And  I fill in "Last name" with "TEST"
  And  I fill in "Street address" with "testaddress"
  And  I fill in "City" with "testcity"
  And  I fill in "State" with "CA"
  And  I fill in "Zipcode" with "testzip"
  And  I fill in "Phone number" with "123-456-7890"
  And  I fill in "Email" with "testuser@test.edu"
  And  I fill in "Password" with "1234"
  And  I fill in "Password confirmation" with "1234"
  And  I press "Register"
  Then I should be located at "/students"
  And I should see "Students"
  And I should see "testuser@test.edu"
  When I go to /user/2/adv_edit
  Then I should see "Edit Account"
  And the "user_first_name" field should contain "testuser1"
  And the "user_last_name" field should contain "TEST"
  And the "user_street_address" field should contain "testaddress"
  And the "user_city" field should contain "testcity"
  And the "user_state" field should contain "CA"
  And the "user_zipcode" field should contain "testzip"
  And the "user_phone_number" field should contain "123-456-7890"
  And the "user_email" field should contain "testuser@test.edu"
  And the "user_password" field should not contain "1234"
  Then I fill in "user_first_name" with "editeduser999"
  And I fill in "user_email" with "changed@email.com"
  And I press "Update"
  Then I should be located at "/students"
  And I should see "editeduser999"
  And I should see "changed@email.com"
  And I should not see "testuser1"
  And I should not see "testuser@test.edu"
  Then I follow "Delete"
  Then I should see "User 'changed@email.com' deleted"
  And I should not see "editeduser999"
