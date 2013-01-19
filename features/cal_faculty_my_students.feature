Feature: Show List of students enrolled in my cal_course
	As an cal faculty
	I want to see all students assigned to my course
	So that I can see the contact information of those students

Background: cal_courses, cal_faculty(me), students exitsts
		Given the following semesters exist
			| id | name | year | status |
			| 1  | Fall | 2012 | Public |
  Given the following cal course exists:
  | name        | school_type		| semester_id |
  | Educ 111	| Elementary School	| 1           |
  | Educ 555	| Elementary School	| 1           |

  Given the following users exist:
  | first_name|last_name| email	               | password| type          | street_address   | phone_number | cal_courses |
  | Cal       | Faculty | calfaculty@berk.edu  | 1234    | CalFaculty    | mystreet1        | 000-111-222  | 1           |
  | stud1     | ent1    | std1@std.edu         | 1234    | Student       | mystreet2        | 333-444-555  | 1           |
  | stud2     | ent2    | std2@std.edu         | 1234    | Student       | mystreet3        | 333-444-555  | 2   	 |
  | stud3     | ent3    | std3@std.edu         | 1234    | Student       | mystreet4        | 333-444-555  | 1   	 |

Scenario: Login as a cal_faculty and see my menus
  Given I am on the login page
  And I fill in "Email" with "calfaculty@berk.edu"
  And I fill in "Password" with "1234"
  And I press "Login"
  And I follow "Fall 2012"
  And I follow "My Students"

Scenario: should see list of my students enrolled in my cal_course
  Given I am on the login page
  And I fill in "Email" with "calfaculty@berk.edu"
  And I fill in "Password" with "1234"
  And I press "Login"
  And I follow "Fall 2012"
  And I follow "My Students"
  Then I should see "stud1"
  And I should not see "stud2"
  And I should see "stud3"
