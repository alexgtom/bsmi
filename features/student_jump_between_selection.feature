Feature: Students should be able to jump between steps when picking their time slots
	As a Student
	I want to be able to jump between steps when picking my timeslots
	So that I can see which step I'm on and how many steps are left.

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
			| id | first_name | last_name | email             | pass | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | oski | Student  | 1           |

		Given the following timeslots exist:
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |

		Given I am logged in as oski@berkeley.edu
	Scenario: Jump between steps
		When I go to /students/1/semesters/1/courses/1/select_timeslots
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
