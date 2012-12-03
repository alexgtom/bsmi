Feature: advisor can change pairings
	As a student advisor
	I want to add new placement and remove automated placements for students
	So that I can finalize students placements.

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

		Given the following mentor teachers exist:
			| first_name    | last_name | address     		| phone_number | email 			   | school 	   |
			| Oski			| Bear      | 2650 Haste Street | 408-123-4567 | oski@berkeley.edu | Berkeley High |

		Given the following timeslots exist:
			| id | start_time     	| end_time      | day     | course    | mentor_teacher |
			| 1  | 8:00		   		| 9:00 			| monday  | Physics   | Oski           |

		Given the following cal course exist
			| id | semester_id | name     |
			| 1  | 1           | EDUC 101 |

		Given the following users exist
			| id | first_name    | last_name    | email                | type     | cal_courses |
			| 3  | Test 	     | Student      | student@berkeley.edu | Student  | 1           |
					
		Given the following users exist
			| id |  first_name | last_name | email                | type     | 
			| 4  |  Orion	   | Zhao      | orion@berkeley.edu   | Advisor  |

		Given I am logged in as orion@berkeley.edu


	Scenario: Student Advisor should be able to see field placement
		Given the following assignments exist
			| user_id | timeslot_id  |
			| 3		     | 1			|

		When I go to /students/3/semesters/1/edit_placements
		Then I should see "Monday"
		Then I should see "8:00 AM to 9:00 AM"
		Then I should see "Physics"
		Then I should see "High School"
		Then I should see "Berkeley High"
		Then I should see "Oski Bear"
		
		
	Scenario: Student Advisor should be able to remove old field placement
		Given the following assignments exist
			| user_id | timeslot_id |
			| 3		  | 1			|

		When I go to /students/3/semesters/1/edit_placements
		Then I should see "Monday"
		Then I should see "8:00 AM to 9:00 AM"
		Then I should see "Physics"
		Then I should see "High School"
		Then I should see "Berkeley High"
		Then I should see "Oski Bear"
	    Then I should see "Remove"                                  
		Then I follow "Remove"
		Then I should see "The selected placement has been removed"
		Then I should not see "Monday"
		Then I should not see "8:00 AM to 9:00 AM"
		Then I should not see "Physics"
		Then I should not see "High School"
		Then I should not see "Berkeley High"
		Then I should not see "Oski Bear"
		
    Scenario: Student Advisor should be able to add new field placement
    
		When I go to /students/3/semesters/1/edit_placements
		Then I should not see "Monday"
		Then I should not see "8:00 AM to 9:00 AM"
		Then I should not see "Physics"
		Then I should not see "High School"
		Then I should not see "Berkeley High"
		Then I should not see "Oski Bear"
		When I fill in "new_timeslot" with "1"
		And I press "Update"
		Then I should see "Monday"
		Then I should see "8:00 AM to 9:00 AM"
		Then I should see "Physics"
		Then I should see "High School"
		Then I should see "Berkeley High"
		Then I should see "Oski Bear"
	    Then I should see "Remove"        
