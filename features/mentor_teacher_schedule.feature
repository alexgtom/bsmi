Feature: Mentor teacher scheduling
  As a mentor teacher
  I want to enter the times and classes that I teach, along with how many students I want to work with me.
  So that I can be matched with students who can help teach my classes.

Background: classes in timeslots

  Given the following schedule exist:
  | timeslots      | class_name        | number_of_assistants |
  | 08:00-08:30    | AP Chemistry      | 1                    |
  | 09:00-09:30    | AP Chemistry      | 1                    |
  | 09:30-10:00    | AP Chemistry      | 1                    |
  | 10:00-10:30    | no class entered  | 0                    |
  | 10:30-11:00    | no class entered  | 0                    |
  | 11:00-11:30    | no class entered  | 0                    |
  | 11:30-12:00    | no class entered  | 0                    |
  | 12:00-12:30    | no class entered  | 0                    |
  | 12:30-13:00    | no class entered  | 0                    |
  | 13:00-13:30    | no class entered  | 0                    |
  | 13:30-14:00    | no class entered  | 0                    |
  | 14:00-14:30    | no class entered  | 0                    |
  | 14:30-15:00    | no class entered  | 0                    |
  | 15:00-15:30    | no class entered  | 0                    |
  | 15:30-16:00    | no class entered  | 0                    |


Scenario: Enter the times and classes that I teach
  When I go to the edit my schedule page
  And  I click on "10:00" to "11:30" timeslot
  Then I should see "10:00" to "11:30" timeslot checked
  And  I fill in "class name" with "Calculus 1"
  And  I fill in "how many students you want to work with" with "2"
  And  I click "submit"
  Then my "10:00" to "11:30" schedule should be "Calculus 1" with "2" student assistants

Scenario: Change the times of a class that I have entered
  When I go to the edit my schedule page
  Then I should see "10:00" to "11:30" timeslot checked with a name of "Calculus 1"
  And  I click on "10:00" to "11:30" timeslot
  Then I should see "10:00" to "11:30" timeslot unchecked
  Then my "10:00" to "11:30" schedule should has a class name of "no class entered" with "0" student assistants