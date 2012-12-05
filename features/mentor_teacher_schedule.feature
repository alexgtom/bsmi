Feature: Mentor teacher scheduling
  As a mentor teacher
  I want to enter the times and classes that I teach, along with how many students I want to work with me.
  So that I can be matched with students who can help teach my classes.

Background: I am a mentor teacher
  Given I am a mentor teacher
  Given the following semesters exist
   | name | year |
   | Fall | 2012 |

  Given the following courses exist:
  | name       | grade |
  | Algebra    |     8 |
  | Prealgebra |     7 |


@javascript
Scenario: Save the times and classes that I teach
  When I go to /mentor_teacher/schedule/new
  And I add the following timeslots on Monday:
   | class_name | start     | end      | num_assistants |
   | Algebra    | 10:00  AM | 11:00 AM |              2 |
   | Prealgebra | 1:00 PM   | 2:30 PM  |              1 |
  And I add the following timeslots on Tuesday:
   | class_name | start_time | end_time | num_assistants |
   | Algebra    | 10:00  AM  | 11:00 AM |              2 |
  And  I press "Save Schedule"

  Then I should be at url /mentor_teacher/schedule

  And my schedule should look like: 
  | day     | class_name | start     | end      | num_assistants |
  | Monday  | Algebra    | 10:00  AM | 11:00 AM |              2 |
  | Monday  | Prealgebra | 1:00 PM   | 2:30 PM  |              1 |
  | Tuesday | Algebra    | 10:00  AM | 11:00 AM |              2 |


@javascript
Scenario: Enter in details for the times and classes I teach
  When I go to /mentor_teacher/schedule/new?semester_id=1
  And I create the following event on the calendar on Monday:
   | start    | end      |
   | 10:00 AM | 11:00 AM |
  Then the "timeslot[start_time(4i)]" field should contain "10"
  And the "timeslot[end_time(4i)]" field should contain "11"
  When I select "Algebra" from "class_name"
  And I select "12 PM" from "timeslot_end_time_4i"
  And I save the event
  Then I should see "Algebra"

# Scenario: Change the times of a class that I have entered
#   When I go to the edit my schedule page
#   Then I should see "10:00" to "11:30" timeslot checked with a name of "Calculus 1"
#   And  I click on "10:00" to "11:30" timeslot
#   Then I should see "10:00" to "11:30" timeslot unchecked
#   Then my "10:00" to "11:30" schedule should has a class name of "no class entered" with "0" student assistants
