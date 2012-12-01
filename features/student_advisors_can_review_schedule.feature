Feature: Student advisors can review students/mentors schedule and contact info
	As a student advisor
	I want to oversee the schedule of the students and teachers
	So that I can make reasonable judgement when the student or the mentor ask me to tweak their schedule
	
	
	Background:
		Given we are currently in a semester
		Given I have students and teachers in system
		Given I am logged in as myemail@nowhere.com
		
		Scenario: view list of students with their information
		  When I go to /user
		  And I follow "Students"
		  Then I should be located at "/students"
		  Then I should see "Andrew"
		  Then I should see "Mains"
		  Then I should see "andrew@berkeley.edu"
		  Then I should see "Orion"
          Then I should see "Allen"
		  Then I should see "orion@berkeley.edu"

		  
		Scenario: view list of mentor teachers with their information
		  When I go to /user
		  And I follow "Teachers"
		  Then I should be located at "/mentor_teachers"
		  Then I should see "Alex"
		  Then I should see "Tom"
		  Then I should see "alex@berkeley.edu"
		  Then I should see "Tony"
                  Then I should see "Adam"
		  Then I should see "tony@berkeley.edu"
		
	    Scenario: sort students by last name
		  Given I am on the students page
		  When I follow "Last Name"
		  Then I should see "Orion" before "Andrew"
		  
		Scenario: sort students by first name
		  Given I am on the students page
		  When I follow "First Name"
		  Then I should see "Andrew" before "Orion"
		  
	    Scenario: sort students by course
		  Given I am on the mentor_teachers page
		  When I follow "Last Name"
		  Then I should see "Tony" before "Alex"
		  
		
		Scenario: sort teachers by last name
		  Given I am on the mentor_teachers page
		  When I follow "Last Name"
		  Then I should see "Tony" before "Alex"
		  
		Scenario: sort teachers by first name
		  Given I am on the mentor_teachers page
		  When I follow "First Name"
		  Then I should see "Alex" before "Tony"
		 
  

