Feature: Student advisors can review students/mentors schedule and contact info
	As a student advisor
	I want to oversee the schedule of the students and teachers
	So that I can make reasonable judgement when the student or the mentor ask me to tweak their schedule
	
	Given the following users exist:
			| name 	    | email               | owner_type        |
			| Mary      | mary@berkeley.edu   | Student           |
			| Oski      | oski@berkeley.edu   | MentorTeacher     |

			
	Given the following courses exist:
			| name 	    | grade 	  |
			| Physics   | High School |
			| Biology   | High School |
			| Geometry  | High School |
			| Algebra 2 | High School |


	Given the following mentor teachers exist:
			| name      | address     		| phone_number | email 			   | school 	   |
			| Oski		| 2650 Haste Street | 408-123-4567 | oski@berkeley.edu | Berkeley High |
			| Kate		| 2650 Haste Street | 408-123-4566 | kate@berkeley.edu | Berkeley High |
			| Alex		| 2650 Haste Street | 408-123-4565 | alex@berkeley.edu | Berkeley High |


	Given the following timeslots exist:
			| id | start_time     	| end_time      | day     | course    | mentor_teacher |
			| 1  | 8:00		   		| 9:00 			| monday  | Physics   | Oski           |
			| 2  | 9:00		   		| 10:00 		| monday  | Biology   | Oski           |
			| 3  | 11:00		   	| 12:00 		| tuesday | Geometry  | Alex           |
			| 4  | 12:00		   	| 13:00 		| tuesday | Algebra 2 | Kate           |


	Given the following students exist
			| id | name  | email             |
			| 1  | Mary  | mary@berkeley.edu |
			| 2  | 


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
  
Scenario: sort students by name
  Given I am on the students page
  When I follow "Name"
  Then I should see "Mary" before "Oski"
  Then I should see "Oski" before "Tony"
  

