Feature: Enter/Upload Course List/Roster/School Districts
	As an adviser
	I want to allow the webapp to populate the students enrolled in the course and the schools that mentor teachers are associated with
	So that the options can be consistent (i.e. title and names) with choice menus

	Background:
		Given the following semesters exist
			| id | name | year | status |
			| 1  | Fall | 2012 | Public |

		Given the following cal course exists:
			| name 		| semester_id |
			| UGIS 80A 	| 1           | 
			| UGIS 80B 	| 1           |
			| ED 130 	| 1           |
			| ED 195C 	| 1           |
			| UGIS 187 	| 1           |
			| UGIS 81A 	| 1           |
			| MATH 197 	| 1           |

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | Student  | 1           |

    Scenario: Student course selections should show up on courses page
        Given I am logged in as oski@berkeley.edu
		When I go to /students/1/semesters/1/select_courses
		And I check "UGIS 80A"
		And I check "UGIS 80B"
		And I press "Save"
		Then I should be at url /students/1/semesters/1/courses/1/select_timeslots/monday
		When I go to /students/1/semesters/1/courses
		Then I should see "UGIS 80A"
		Then I should see "UGIS 80B"
		Then I should not see "ED 130"
		Then I should not see "ED 195C"
		Then I should not see "UGIS 187"
		Then I should not see "UGIS 81A"
		Then I should not see "MATH 197"
