Feature: Student advisors can review students/mentors schedule and contact info
	As a student advisor
	I want to oversee the schedule of the students and teachers
	So that I can make reasonable judgement when the student or the mentor ask me to tweak their schedule

Given the following users exist:
			| name | email 		       | owner_type       |
			| Oski | oski@berkeley.edu | Student          | 
			| Bob  | bob@berkeley.edu  | Student          |
			| Tony | tony@berkeley.edu | Student          |
			| Mary | mary@berkeley.edu | MentorTeacher    |
			| Kate | Kate@berkeley.edu | MentorTeacher    |
			| Alex | alex@berkeley.edu | MentorTeacher    |
			


Scenario: view list of students with their information
  Given I am on the advisors page
  And I follow "Student Roster"
  Then I should be located at "/students"
  And I should see "Oski"
  And I should see "oski@berkeley.edu"
  
  
Scenario: sort students by name
  Given I am on the students page
  When I follow "Name"
  Then I should see "Bob" before "Oski"
  Then I should see "Oski" before "Tony"
  

Scenario: sort students by course
  Given I am on the students page
  When I follow "Course"
  Then I should see "2001: A Space Odyssey" before "Aladdin"
  Then I should see "Aladdin" before "Amelie"
  Then I should see "Amelie" before "Chicken Run"

