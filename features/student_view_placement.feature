Feature: Students should be able to view the options  
	As a Cal Student
	I want to be able to see the school, mentor teacher, grade level, subject matter, and time for my field placements
	So that I can select my field placement

	Background:
		Given the following semesters exist
			| id | name | year | status |
			| 1  | Fall | 2012 | Public |
		Given the following courses exist:
			| name 	    | grade 	  |
			| Physics   | High School |
			| Biology   | High School |
			| Geometry  | High School |
			| Algebra 2 | High School |

		Given the following districts exist:
			| name |
			| BUSD |

		Given the following schools exist:
			| district | level       | name          |
			| BUSD     | High School | Berkeley High |

		Given the following users exist:
			| id | first_name    | last_name | address     		| phone_number | email 			   | school 	   | type |
			| 2 | Oski			| Bear      | 2650 Haste Street | 408-123-4567 | mt@berkeley.edu | Berkeley High | MentorTeacher |

		Given the following timeslots exist:
			| id | start_time     	| end_time      | day     | course    | mentor_teacher |
			| 1  | 8:00		   		| 9:00 			| monday  | Physics   | Oski           |
			| 2  | 9:00		   		| 10:00 		| monday  | Biology   | Oski           |
			| 3  | 11:00		   	| 12:00 		| tuesday | Geometry  | Oski           |
			| 4  | 12:00		   	| 13:00 		| tuesday | Algebra 2 | Oski           |

		Given the following cal course exist
			| id | semester_id |
			| 1  | 1           |

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | Oski 	  | Bear      | oski@berkeley.edu | Student  | 1           |

		Given I am logged in as oski@berkeley.edu


	Scenario: Student should be able to see field placement
		Given the following assignments exist
			| user_id | timeslot_id |
			| 1		  | 1			|

		When I go to /students/1/semesters/1/placements
		Then I should see "Monday"
		Then I should see "8:00 AM to 9:00 AM"
		Then I should see "Physics"
		Then I should see "High School"
		Then I should see "Berkeley High"
		Then I should see "Oski Bear"

	Scenario: Student should be able to see multiple field placements
		Given the following assignments exist
			| user_id | timeslot_id |
			| 1		  | 1			|
			| 1		  | 3       	|

		When I go to /students/1/semesters/1/placements

		# first timeslot
		Then I should see "Monday"
		Then I should see "8:00 AM to 9:00 AM"
		Then I should see "Physics"
		Then I should see "High School"
		Then I should see "Berkeley High"
		Then I should see "Oski Bear"

		# second timeslot
		Then I should see "Tuesday"
		Then I should see "11:00 AM to 12:00 PM"
		Then I should see "Geometry"
		Then I should see "High School"
		Then I should see "Berkeley High"
		Then I should see "Oski Bear"

