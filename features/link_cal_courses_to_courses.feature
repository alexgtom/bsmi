Feature: Link Cal courses to K-12 subjects/grades
	As an adviser
	I want to specify which Cal courses can teach which subjects/grades
	So that students can be matched with a course they are training to teach

        Background: classes, mentor teachers and timeslots are created

		Given the following timeslots exist:
			| start_time       | end_time                   | day     | id |
			| 8:00		   | 9:00 			| monday  | 1  |
			| 9:00		   | 10:00 			| monday  | 2  |
			| 11:00		   | 12:00 			| tuesday | 3  |
			| 12:00		   | 13:00 			| tuesday | 4  |
                Given the following school exist:
		Given the following mentor teacher exist:
			| id | name     | school          |
			| 1  | Bob Ross | El Cerrito High |

	Scenario: Add a Cal Course
		When I go to /cal_course/new
		
