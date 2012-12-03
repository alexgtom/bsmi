Feature: Students should be able to change their schedules without approval from student advisor before a specific deadline
	As a Cal Student
	I want to be able to change my schedule on the application
	So that I can be scheduled

	Background:
	
	Scenario: Students cannot change timeslot preferences after deadline
		Given a semester with a passed deadline with id 1

		Given the following cal course exist
			| id | semester_id |
			| 1  | 1           |
		Given the following courses exist
			| id | name | grade |
			| 1  | MATH | 1     |

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | Student  | 1           |

		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |

		Given I am logged in as oski@berkeley.edu

		When I go to /students/1/semesters/1/courses/1/select_timeslots/monday
		Then I should see "The deadline for registration has already passed."
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		Then I should see "The deadline for registration has already passed."

	Scenario: Students cannot change timeslot preferences after deadline
		Given a semester with a not passed deadline with id 1

		Given the following cal course exist
			| id | semester_id |
			| 1  | 1           |
		Given the following courses exist
			| id | name | grade |
			| 1  | MATH | 1     |

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | Student  | 1           |

		Given the following timeslots exist
			| start_time     | end_time     | day     | cal_course_id | course_id | 
			| 8:00		     | 9:00 		| monday  | 1             | 1         |
			| 9:00		     | 10:00 		| monday  | 1             | 1         |
			| 11:00		     | 12:00 		| tuesday | 1             | 1         |
			| 12:00		     | 13:00 		| tuesday | 1             | 1         |

		Given I am logged in as oski@berkeley.edu

		When I go to /students/1/semesters/1/courses/1/select_timeslots/monday
		Then I should not see "The deadline for registration has already passed."
		When I go to /students/1/semesters/1/courses/1/select_timeslots/rank
		Then I should not see "The deadline for registration has already passed."
