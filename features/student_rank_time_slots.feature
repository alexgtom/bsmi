Feature: Ranking possible student times
  As a student 
  I want to rank which time slots I can work with in order of my preference
  So that I can be matched with a class to match my schedule

Background: classes in timeslots

  Given the following timeslots exist:
  | timeslots      | class_name        |
  | 08:00-08:30    | no class entered  |
  | 09:00-09:30    | no class entered  |
  | 09:30-10:00    | no class entered  |
  | 10:00-10:30    | no class entered  |
  | 10:30-11:00    | no class entered  |
  | 11:00-11:30    | no class entered  |
  | 11:30-12:00    | no class entered  |
  | 12:00-12:30    | no class entered  |
  | 12:30-13:00    | no class entered  |
  | 13:00-13:30    | no class entered  |
  | 13:30-14:00    | no class entered  |
  | 14:00-14:30    | no class entered  |
  | 14:30-15:00    | no class entered  |
  | 15:00-15:30    | no class entered  |
  | 15:30-16:00    | no class entered  |


Scenario: Enter my time preferences
  When I go to the edit my schedule page
  And  I click on "10:00" to "11:30" timeslot
  Then I should see "10:00" to "11:30" timeslot checked
  And  I rank it as 4
  And  I click "submit"
  Then my preference for "10:00" to "11:30" timeslot should be 4

Scenario: Change my time preferences
  When I go to the edit my schedule page
  And  I click on "10:00" to "11:30" timeslot
  Then I should see "10:00" to "11:30" timeslot checked
  And  I rank it as 2
  And  I click "submit"
  Then my preference for "10:00" to "11:30" timeslot should be 2

Scenario: Remove one class that I selected before
  When I go to the edit my schedule page
  And  I click on "10:00" to "11:30" timeslot
  Then I should see "10:00" to "11:30" timeslot checked
  And  I click "remove"
  Then I should see "10:00" to "11:30" timeslot unchecked
  Then my preference for "10:00" to "11:30" timeslot should be 0
