Feature: Mentor teacher scheduling
  As a mentor teacher
  I want to enter the times and classes that I teach, along with how many students I want to work with me.
  So that I can be matched with students who can help teach my classes.
  
Background: classes in timeslots

  Given the following movies exist:
  | timeslots          | class_name | number_of_assistants |
  | 10:00AM-10:30AM    | PG         | 2                    |
  | 10:00AM-10:30AM    | PG         | 2                    |
  | 10:00AM-10:30AM    | PG         | 2                    |
  

Scenario: Enter the times and classes that I teach
  When I go to the edit my schedule page
  And  I click on "10:00AM" to "11:30AM" timeslot
  Then I should see "10:00AM" to "11:30AM" timeslot checked
  And  I fill in "class name" with "Calculus 1"
  And  I fill in "how many students you want to work with" with "2"
  And  I click "submit"
  Then my "10:00AM" to "11:30AM" schedule should be "Calculus 1" with "2" students assistants

Scenario: Change the times of a class that I have entered
  When I go to the edit my schedule page
  Then I should see "10:00AM" to "11:30AM" timeslot checked
  Then I should see "10:00AM" to "11:30AM" timeslot has a name of "Calculus 1"
  Then I should see "10:00AM" to "11:30AM" timeslot checked

  And  I click on "10:00AM" to "11:30AM" timeslot
  Then I should see "10:00AM" to "11:30AM" timeslot unchecked
  And  I fill in "class name" with "Calculus 1"
  And I click "submit"
  Then my "10:00AM" to "11:30AM" schedule should be "Calculus 1"
