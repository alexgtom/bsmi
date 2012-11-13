Feature: Students should be able to jump between steps when picking their time slots
	As a Student
	I want to be able to jump between steps when picking my timeslots
	So that I can see which step I'm on and how many steps are left.

	Background: classes in timeslots

		Given the following cal course exist
			| id |
			| 1  |

		Given the following student exist
			| id | cal_courses |
			| 1  | 1 		  |

		Given the following timeslots exist:
			| start_time     | end_time     | day     | cal_course_id |
			| 8:00		     | 9:00 		| monday  | 1             |
			| 9:00		     | 10:00 		| monday  | 1             |
			| 11:00		     | 12:00 		| tuesday | 1             |
			| 12:00		     | 13:00 		| tuesday | 1             |

	Scenario: Jump between steps
		When I go to /students/1/courses/1/select_timeslots
		Then I should see "Monday"
		Then I should see "Tuesday"
		Then I should see "Wednesday"
		Then I should see "Thursday"
		Then I should see "Friday"
		Then I should see "Rank"
		Then I should see "Summary"
		When I follow "Monday"
		Then I should see "Monday"
		Then I should see "Tuesday"
		Then I should see "Wednesday"
		Then I should see "Thursday"
		Then I should see "Friday"
		Then I should see "Rank"
		Then I should see "Summary"
		When I follow "Friday"
		Then I should see "Monday"
		Then I should see "Tuesday"
		Then I should see "Wednesday"
		Then I should see "Thursday"
		Then I should see "Friday"
		Then I should see "Rank"
		Then I should see "Summary"
		When I follow "Rank"
		Then I should see "Monday"
		Then I should see "Tuesday"
		Then I should see "Wednesday"
		Then I should see "Thursday"
		Then I should see "Friday"
		Then I should see "Rank"
		Then I should see "Summary"
		When I follow "Summary"
		Then I should see "Monday"
		Then I should see "Tuesday"
		Then I should see "Wednesday"
		Then I should see "Thursday"
		Then I should see "Friday"
		Then I should see "Rank"
		Then I should see "Summary"
