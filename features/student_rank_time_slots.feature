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
  And I rank it as 4
  Then I should see "10:00" to "11:30" timeslot checked
  And I click "submit"
  Then my preference for "10:00" to "11:30" timeslot should be 4

Scenario: Change the times of a class that I have entered
  When I go to the edit my schedule page
  Then I should see "10:00AM" to "11:30AM" timeslot checked
  Then I should see "10:00AM" to "11:30AM" timeslot with a name of "Calculus 1"
  And  I click on "10:00AM" to "11:30AM" timeslot
  Then I should see "10:00AM" to "11:30AM" timeslot unchecked
  Then my "10:00AM" to "11:30AM" schedule should be "no class entered" with "0" student assistants