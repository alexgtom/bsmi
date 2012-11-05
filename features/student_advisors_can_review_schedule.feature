Feature: Student advisors can review students/mentors schedule and contact info
	As a student advisor
	I want to oversee the schedule of the students and teachers
	So that I can make reasonable judgement when the student or the mentor ask me to tweak their schedule
	
	
	Background:
	    Given the following users exist:
				| first_name | last_name   |  email              | owner_type        |
				| Alex       | Tom         | alex@berkeley.edu   | Student           |
				| Mary       | Liu         | mary@berkeley.edu   | Student           |
				| Tina       | Allen       | tina@berkeley.edu   | Student           |
				| Will       | Lee         | will@berkeley.edu   | MentorTeacher     |
				| Jerry      | Kim         | jerry@berkeley.edu  | MentorTeacher     |
				| Oski       | Wang        | oski@berkeley.edu   | MentorTeacher     |



Scenario: view list of students with their information
  Given I am on the advisors page
  And I follow "Student Roster"
  Then I should be located at "/students"
  Then I should see "Mary"
  Then I should see "mary@berkeley.edu"
  
Scenario: view list of mentor teachers with their information
  Given I am on the advisors page
  And I follow "Teacher Roster"
  Then I should be located at "/mentor_teachers"
  Then I should see "Oski"
  Then I should see "oski@berkeley.edu"

Scenario: sort students by first name
  Given I am on the students page
  When I follow "First Name"
  Then I should see "Mary" before "Oski"
  Then I should see "Oski" before "Tony"
  
Scenario: sort students by last name
  Given I am on the students page
  When I follow "Last Name"
  Then I should see "Mary" before "Oski"
  Then I should see "Oski" before "Tony"
 
  

