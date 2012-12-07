Feature: One click matching
	As a student advisor
	I want to be able to automatically match Cal students to mentor teachers 
	So that I do not need to match students and mentor teachers manually


Background:
  Given I am signed up as a student advisor
  Given I am logged in as myemail@nowhere.com
  Given the following semesters exist
     | name | year |
     | Fall | 2012 |

Scenario: I haven't already run the matching algorithm
  Given I am on /matching/new  
  When I press "match_all"
  Then I should be on /matching

#Scenario: I have already run the matching algorithm
#  Given matchings have been performed for this semester
#  And I am on /matching
#  Then I should see "UGIS 80"
