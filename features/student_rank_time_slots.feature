Feature: Ranking possible student times
	As a student 
	I want to rank which time slots I can work with in order of my preference
	So that I can be matched with a class to match my schedule

	Background: classes in timeslots

		Given the following timeslots exist:
			| start_time     | end_time       | day     |
			| 8:00 am		   | 9:00 am 			| monday  |
			| 9:00 am		   | 10:00 am 			| monday  |
			| 11:00 am		   | 12:00 pm			| tuesday |
			| 12:00	pm	   | 1:00 pm 			| tuesday |

		Given the following student exist
			| id |
			| 1  |

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


	Scenario: Change my time preferences
		When I go to the edit my schedule page
		And  I click on "10:00" to "11:30" timeslot
		Then I should see "10:00" to "11:30" timeslot checked
		And  I rank it as 2
		And  I click "submit"
		Then my preference for "10:00" to "11:30" timeslot should be 2

	Scenario: Remove one class that I selected before
		When I go to the edit my schedule page
		And  I click on "10:00" to "11:30" timeslot
		Then I should see "10:00" to "11:30" timeslot checked
		And  I click "remove"
		Then I should see "10:00" to "11:30" timeslot unchecked
		Then my preference for "10:00" to "11:30" timeslot should be 0

