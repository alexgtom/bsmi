Feature: Ranking possible student times
	As a student 
	I want to rank which time slots I can work with in order of my preference
	So that I can be matched with a class to match my schedule

	Background: classes in timeslots
		Given the following semesters exist
			| id | name | year | status |
			| 1  | Fall | 2012 | Public |

		Given the following cal course exist
			| id | semester_id |
			| 1  | 1           |
		Given the following courses exist
			| id | name | grade |
			| 1  | MATH | 1     |

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | Student  | 1           |


		Given I am logged in as oski@berkeley.edu

	Scenario: User can't submit invalid preferences
		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |

		When I go to /students/1/semesters/1/courses/1/select_timeslots/friday
		And I press "Save"
		When I go to /students/1/semesters/1/courses/1/select_timeslots/friday
		And I press "Save & Continue"
		Then I should see "You must select 3-5 timeslots."
		When I go to /students/1/semesters/1/courses/1/select_timeslots/summary
		Then I should see "You must select 3-5 timeslots."
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		Then I should see "You must select 3-5 timeslots."
	
	@javascript
	Scenario: User can submit timeslots if the number of timeslots available is less than the number of timeslots required but greater than zero
		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
		When I go to /students/1/semesters/1/courses/1/select_timeslots
		When I click element containing "08:00 am to 09:00 am"
		Then I press "Save & Continue"
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		Then I should not see "You must select 3-5 timeslots."

	Scenario: User can submit timeslots if the number of timeslots available is less than the number of timeslots required but greater than one
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		Then I should not see "You must select 3-5 timeslots."
		
	@javascript 
	Scenario: User can't select the same ranking for two preferences
		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |

		Given the following preferences exist:
			| student_id | timeslot_id | ranking | 
			| 1          | 1           | 1       |
			| 1          | 2           | 2       |
			| 1          | 3           | 3       |
			| 1          | 4           | 4       |
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		When I select "1" from "student[preferences_attributes][0][ranking]"
		When I select "1" from "student[preferences_attributes][1][ranking]"
		When I select "3" from "student[preferences_attributes][2][ranking]"
		When I select "4" from "student[preferences_attributes][3][ranking]"
		And I press "Submit Rankings"
		Then I should see "The ranking for preference must be unique."

		# these next steps chaeck to make sure the rankings have not been
		# modified from before
		When I go to /students/1/semesters/1/courses/1/select_timeslots/summary
		Then I should see /1.*8:00 am.*9:00 am/
		Then I should see /2.*9:00 am.*10:00 am/
		Then I should see /3.*11:00 am.*12:00 pm/
		Then I should see /4.*12:00 pm.*1:00 pm/

	@javascript 
	Scenario: Remove one class that I selected before
		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |

		Given the following preferences exist:
			| student_id | timeslot_id | ranking | 
			| 1          | 1           | 1       |
			| 1          | 2           | 2       |
			| 1          | 3           | 3       |
			| 1          | 4           | 4       |
		When I go to /students/1/semesters/1/courses/1/select_timeslots
		When I click element containing "09:00 am to 10:00 am"
		And I press "Save"
		When I go to /students/1/semesters/1/courses/1/select_timeslots/summary
		Then I should not see /9:00 am.*10:00 am/
		Then I should see /1.*8:00 am.*9:00 am/
		Then I should see /2.*11:00 am.*12:00 pm/
		Then I should see /3.*12:00 pm.*1:00 pm/

	@javascript 
	Scenario: Enter my time preferences
		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |
		When I go to /students/1/semesters/1/courses/1/select_timeslots
		When I click element containing "08:00 am to 09:00 am"
		When I click element containing "09:00 am to 10:00 am"
		And I press "Save & Continue"
		When I click element containing "11:00 am to 12:00 pm"
		When I click element containing "12:00 pm to 01:00 pm"
		And I press "Save & Continue"
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		When I select "1" from "student[preferences_attributes][0][ranking]"
		When I select "2" from "student[preferences_attributes][1][ranking]"
		When I select "3" from "student[preferences_attributes][2][ranking]"
		When I select "4" from "student[preferences_attributes][3][ranking]"
		And I press "Submit Rankings"

