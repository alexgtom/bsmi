Feature: Ranking possible student times
	As a student 
	I want to rank which time slots I can work with in order of my preference
	So that I can be matched with a class to match my schedule

	Background: classes in timeslots

		Given the following timeslots exist:
			| id | start_time   | end_time          | day     |
			| 1  | 8:00 am		| 9:00 am 			| monday  |
			| 2  | 9:00 am		| 10:00 am 			| monday  |
			| 3  | 11:00 am		| 12:00 pm			| tuesday |
			| 4  | 12:00 pm	    | 1:00 pm 			| tuesday |

		Given the following student exist
			| id |
			| 1  |

	@javascript 
	Scenario: Remove one class I selected before
		Given the following preferences exist:
			| student_id | timeslot_id | ranking | 
			| 1          | 1           | 1       |
			| 1          | 2           | 2       |
			| 1          | 3           | 3       |
			| 1          | 4           | 4       |
		When I go to /students/1/select_timeslots
		When I click element containing "09:00 am to 10:00 am"
		And I press "Save"
		# rankings should auto currect themselves. For example [1, 3, 4] 
		# becomes [1, 2, 3]
		When I go to /students/1/select_timeslots/summary
		Then I should not see /9:00 am.*10:00 am/
		Then I should see /1.*8:00 am.*9:00 am/
		Then I should see /2.*11:00 am.*12:00 pm/
		Then I should see /3.*12:00 pm.*1:00 pm/

	@javascript 
	Scenario: Enter my time preferences
		When I go to /students/1/select_timeslots
		When I click element containing "08:00 am to 09:00 am"
		When I click element containing "09:00 am to 10:00 am"
		And I press "Save & Continue"
		When I click element containing "11:00 am to 12:00 pm"
		When I click element containing "12:00 pm to 01:00 pm"
		And I press "Save & Continue"
		When I go to /students/1/select_timeslots/rank
		When I select "1" from "student[preferences_attributes][0][ranking]"
		When I select "2" from "student[preferences_attributes][1][ranking]"
		When I select "3" from "student[preferences_attributes][2][ranking]"
		When I select "4" from "student[preferences_attributes][3][ranking]"
		And I press "Submit Rankings"

