Feature: Enter/Upload Course List/Roster/School Districts
	As an adviser
	I want to allow the webapp to populate the students enrolled in the course and the schools that mentor teachers are associated with
	So that the options can be consistent (i.e. title and names) with choice menus

	Background:
		Given the following cal course exists:
			| name 		|
			| UGIS 80A 	|
			| UGIS 80B 	|
			| ED 130 	|
			| ED 195C 	|
			| UGIS 187 	|
			| UGIS 81A 	|
			| MATH 197 	|

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | Student  | 1           |

	Scenario: Student course selections should show up on courses page
		When I go to /students/1/select_courses
		And I check "UGIS 80A"
		And I check "UGIS 80B"
		And I press "Save"
		Then I should be at url /students/1/courses
		Then I should see "UGIS 80A"
		Then I should see "UGIS 80B"
