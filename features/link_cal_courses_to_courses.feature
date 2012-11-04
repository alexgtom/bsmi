Feature: Link Cal courses to K-12 subjects/grades
	As an adviser
	I want to specify which Cal courses can teach which subjects/grades
	So that students can be matched with a course they are training to teach

Background: classes, mentor teachers and timeslots are created
  Given the following timeslots exist:
  | start_time	| end_time	| day	| class_name	| course_id	| mentor_teacher_id	| cal_course_id	|
  | 8:00 AM	| 9:00 AM	| Mon	| Calculus	| 1		| 1			| 1		|
  | 9:00 AM	| 10:00 AM	| Mon	| Precalc	| 2		| 1			| 1		|
  | 11:00 AM	| 12:00 AM	| Tue	| Math		| 3		| 2			| 5		|
  | 12:00 AM	| 1:00 PM	| Tue	| Calculus	| 1		| 1			| 5		|
  Given the following courses exist:
  | name	| grade		|
  | Calculus	| HIGH_SCHOOL	|
  | Precalc	| 8		|
  | Math	| 2		|
  Given the mentor teachers from the table exists:
  | name	| email		| password	| type		| school    		|
  | Bob Ross	| se@se.com	| 12345		| MentorTeacher	| El Cerrito High	|
  | Ren Gar	| col@col.net	| 23456		| MentorTeacher	| Ocean View		|
  Given the following district exists:
  | name		|
  | Berkeley North	|
  Given the following school exists:
  | name		| level			| district_id 	|
  | El Cerrito High	| High School		| 1 		|
  | Ocean View		| Elementary School	| 1 		|
  Given the following cal course exists:
  | name        | school_type		| course_grade	|
  | Educ 111	| Elementary School	| 8		|

Scenario: Add a Cal Course
  Given I am in the CalCourse new page
  And  I fill in "Name" with "Educ 101"
  And  I select "Middle School" from "School type"
  And  I select "8" from "Course grade"
  And  I check "timeslots_1"
  And  I press "Save"
  Then I should be located at "/cal_courses/2"
  And I should see "Educ 101"
  And I should see "Middle School"
  And I should see "8"
  And I should see "Calculus"
  And I should see "Mon|08:00AM|09:00AM"
  And I should see "Bob Ross"
  And I should not see "Precalc"
  And I should not see "Ren Gar"

Scenario: Check the Index Page
  Given I am in the CalCourse index page
  Then I should see "Educ 111"
  And I should see "Elementary School"
  And I should see "8"
  And I should not see "Educ 101"
  And I should not see "Middle School"
  And I should not see "High School"

Scenario: Check the Show page
  Given I am in the CalCourse show 1 page
  Then I should see "Educ 111"
  And I should see "Elementary School"
  And I should see "8"
  And I should not see "Educ 101"
  And I should not see "Middle School"
  And I should not see "High School"
  And I should see "Calculus"
  And I should see "Mon|08:00AM|09:00AM"
  And I should see "Bob Ross"
  And I should see "Precalc"
  And I should see "Mon|09:00AM|10:00AM"
  And I should not see "Ren Gar"
  And I should not see "Math"
  And I should not see "Tue|11:00AM|12:00AM"
  And I should not see "Tue|12:00AM|01:00PM"


Scenario: Check the Edit Page
  Given I am in the CalCourse edit 1 page
  And the "cal_course_name" field should contain "Educ 111"
  And I should see "Elementary School"
  And I should see "8"
  And I should see "Bob Ross"
  And I should see "Ren Gar"
  And I should see "El Cerrito High"
  And I should see "Ocean View"
  And I should see "Mon|08:00AM|09:00AM"
  And I should see "Mon|09:00AM|10:00AM"
  And I should see "Tue|11:00AM|12:00AM"
  And I should see "Tue|12:00AM|01:00PM"
  And  I check "timeslots_3"
  And  I check "timeslots_4"
  And  I press "Save"
  Then I should be located at "/cal_courses/1"
  And I should see "Educ 111"
  And I should see "Elementary School"
  And I should see "8"
  And I should see "Tue|11:00AM|12:00AM"
  And I should see "Tue|12:00AM|01:00PM"
  And I should not see "Mon|08:00AM|09:00AM"
  And I should not see "Mon|09:00AM|10:00AM"
  And I should see "Math"
  And I should see "Calculus"
  And I should not see "Precalc"
  And I should see "Bob Ross"
  And I should see "Ren Gar"		





		
