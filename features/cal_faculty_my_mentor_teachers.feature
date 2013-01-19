Feature: Show List of mentor teachers enrolled in my cal_course
	As an cal faculty
	I want to see all mentor teachers assigned to my course
	So that I can see the contact information of those mentor teachers

Background: cal_courses, cal_faculty(me), students exitsts
		Given the following semesters exist
			| id | name | year | status |
			| 1  | Fall | 2012 | Public |
  Given the following cal course exists:
  | name        | school_type		| semester_id |
  | Educ 111	| Elementary School	| 1           |
  | Educ 555	| Elementary School	| 1           |

  Given the following timeslots exist:
  | start_time | end_time | day     | course_id | mentor_teacher_id	| cal_course_id |
  | 8:00 AM    | 9:00 AM  | monday  | 1	        | 1		            | 1          |
  | 9:00 AM    | 10:00 AM | monday  | 2	        | 2		            | 2          |
  | 9:00 AM    | 10:00 AM | monday  | 3	        | 3			        | 2          |

  Given the following users exist:
  | first_name|last_name| email	               | password| type          | street_address   | phone_number | cal_courses |
  | Cal       | Faculty | calfaculty@berk.edu  | 1234    | CalFaculty    | mystreet1        | 000-111-222  | 1   	 |
  | stud1     | ent1    | std1@std.edu         | 1234    | Student       | mystreet2        | 333-444-555  | 1   	 |
  | stud2     | ent2    | std2@std.edu         | 1234    | Student       | mystreet3        | 333-444-555  | 2   	 |
  | stud3     | ent3    | std3@std.edu         | 1234    | Student       | mystreet4        | 333-444-555  | 1  	 |
  | mentor1   | ment1   | mt1@std.edu          | 1234    | MentorTeacher | mystreet5        | 333-444-555  |    	 |
  | mentor2   | ment2   | mt2@std.edu          | 1234    | MentorTeacher | mystreet6        | 333-444-555  |   	  	 |
  | mentor3   | ment3   | mt3@std.edu          | 1234    | MentorTeacher | mystreet7        | 333-444-555  |    	 |

  Given the students_timeslots exists:
  | student_id | timeslot_id |
  | 1          | 1           |

  Given the matchings exists:
  | student_id | timeslot_id | ranking |
  | 1          | 1           | 1       |

Scenario: Login as a cal_faculty and see my menus
  Given I am on the login page
  And I fill in "Email" with "calfaculty@berk.edu"
  And I fill in "Password" with "1234"
  And I press "Login"
  Then I should be located at "/cal_faculty/home"
  And I follow "Fall 2012"
  And I follow "My Mentor Teachers"
  Then I should be located at "/cal_faculty/my_mentor_teachers"

Scenario: should see list of my mentor teachers enrolled in my cal_course
  Given I am on the login page
  And I fill in "Email" with "calfaculty@berk.edu"
  And I fill in "Password" with "1234"
  And I press "Login"
  And I follow "Fall 2012"
  And I follow "My Mentor Teachers"
  Then I should see "mentor1"
  And I should not see "mentor2"
  And I should not see "mentor3"
  And I should not see "stud1"
  And I should not see "stud2"
  And I should not see "stud3"
