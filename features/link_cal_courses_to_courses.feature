Feature: Link Cal courses to K-12 subjects/grades
	As an adviser
	I want to specify which Cal courses can teach which subjects/grades
	So that students can be matched with a course they are training to teach

Background: classes, mentor teachers and timeslots are created
  Given the following semesters exists:
  | name   | year  | start_date   |  end_date  |
  | Fall   | 2012  | 2012-08-22   | 2012-12-16 |
  Given the following cal course exists:
  | name        |  semester_id |
  | Educ 111	|  1             |
  | Math 101    |  1             |
  Given the following timeslots exist:
	  | id | start_time | end_time | day     | course_id | mentor_teacher_id	| cal_course_id	|
  	  | 1  | 8:00 AM    | 9:00 AM  | monday  | 1	     | 1	        	| 		|
  	  | 2  | 9:00 AM    | 10:00 AM | monday  | 2	     | 1	        	| 1		|
  	  | 3  | 11:00 AM   | 12:00 AM | tuesday | 3	     | 2	        	| 2		|
  	  | 4  | 12:00 AM   | 1:00 PM  | tuesday | 1	     | 1	        	| 2		|
          | 5  | 12:00 AM   | 1:00 PM  | monday  | 2         | 2                        |               |
  Given the following courses exist:
  | name	| grade		|
  | Calculus	| HIGH_SCHOOL	|
  | Precalc	| 5		|
  | Math	| 2		|
  Given the following districts exist:
  | name		|
  | Berkeley North	|
  Given the following schools exist:
  | name		| level			| district 	 |
  | El Cerrito High	| High School		| Berkeley North |
  | Ocean View		| Elementary School	| Berkeley North |
  Given Given the following mentor teachers exist: 
  | first_name|last_name| email	| password| type    | school    | street_address   | phone_number |
  | Bob | Ross | se@se.com  | 12345 | MentorTeacher | El Cerrito High | 1 Er way  | 000-111-222  |
  | Ren | Gar  | col@col.net| 23456 | MentorTeacher | Ocean View      | 2 Re Blvd | 333-444-555  |
  
  Given I am signed up as a student advisor
  Given I am logged in as myemail@nowhere.com

Scenario: Add succesfully a Cal Course
    When I go to /cal_courses
    And I follow "Fall 2012"
    And I follow "New Course"
  And  I fill in "Name" with "Educ 101"
  And  I check "timeslots[1]"
  And  I press "Save"
  Then I should be located at "/cal_courses/3"
  And I should see /Educ 101/
  And I should see /Monday.*08:00AM.*09:00AM/
  And I should see /Bob Ross/
  And I should not see /Precalc/
  And I should not see /Ren Gar/

Scenario: Add a Cal Course with errors
    When I go to /cal_courses
    And I follow "Fall 2012"
    And I follow "New Course"
  And  I fill in "Name" with ""
  And  I check "timeslots[1]"
  And  I press "Save"
  Then I should see /Name can't be blank/

Scenario: Check the Index Page and delete action
    When I go to /cal_courses
    And I follow "Fall 2012"
  Then I should see /Educ 111/
  And I should see /Math 101/
  And I should not see /Educ 101/
  And I follow "Destroy"
  And I should see "'Educ 111' succesfully destroyed."
  And I should see /Math 101/
  And I should not see /Educ 101/

Scenario: Check the Index Page sorting feature
    When I go to /cal_courses
    And I follow "Fall 2012"
  Then I should see /Educ 111/
  And I should see /Math 101/
  And I follow "Name"
  Then I should see "Educ 111" before "Math 101"

Scenario: Check the Show page
  Given I am in the CalCourse show 1 page
  Then I should see "Educ 111"
  And I should not see /Educ 101/
  And I should not see /Middle School/
  And I should not see /High School/
  And I should not see /Calculus/
  And I should not see /Monday.*08:00AM.*09:00AM/
  And I should see /Bob Ross/
  And I should see /Precalc/
  And I should see /Monday.*09:00AM.*10:00AM/
  And I should not see /Ren Gar/
  And I should not see /Math/
  And I should not see /Tuesday.*11:00AM.*12:00AM/
  And I should not see /Tuesday.*12:00AM.*01:00PM/


Scenario: Check the Edit Page
  Given I am in the CalCourse edit 1 page
  And the "cal_course_name" field should contain "Educ 111"
  And I should see /Bob Ross/
  And I should see /Ren Gar/
  And I should see /El Cerrito High/
  And I should see /Ocean View/
  And I should see /Monday.*08:00AM.*09:00AM/
  And I should see /Monday.*09:00AM.*10:00AM/
  And I should not see /Tuesday.*11:00AM.*12:00AM/
  And I should not see /Tuesday.*12:00AM.*01:00PM/
  And  I check "timeslots[1]"
  And  I press "Save"
  Then I should be located at "/cal_courses/1"
  And I should see /Educ 111/
  And I should not see /Tuesday.*11:00AM.*12:00AM/
  And I should not see /Tuesday.*12:00AM.*01:00PM/
  And I should see /Monday.*08:00AM.*09:00AM/
  And I should see /Monday.*09:00AM.*10:00AM/
  And I should not see /Math/
  And I should see /Calculus/
  And I should see /Precalc/
  And I should see /Bob Ross/
  And I should not see /Ren Gar/		
