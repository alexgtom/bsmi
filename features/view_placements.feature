Feature: View placements
	As a Cal Faculty member
	I want to see which placements have been made
	So that I can know what kind of schedule students get assigned.

	Background:
		Given the following semesters exist
			| id | name | year | status |
			| 1  | Fall | 2012 | Public |

		Given the following cal course exist
			| id | semester_id |
			| 1  | 1           |

		Given the following users exist
			| id | first_name | last_name | email             | type     | cal_courses |
			| 1  | cf		  | Bear      | s@berkeley.edu   | Student | 1 	          |
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
			| id | first_name    | last_name | address     		| phone_number | email 			   | school 	   | type 		   |
			|  2 | Oski			 | Bear      | 2650 Haste Street | 408-123-4567 | mt@berkeley.edu | Berkeley High | MentorTeacher |

		Given the following timeslots exist:
			| id | start_time     	| end_time      | day     | course    | mentor_teacher |
			| 1  | 8:00		   		| 9:00 			| monday  | Physics   | Oski           |


		Given I am logged in as s@berkeley.edu


	Scenario: Cal Faculty should be able to see field placement
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
