# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
names = %w(
  Selina
  Merlin
  Buford
  Antonia
  Roy
  Rozella
  Brad
  Ida
  Jessenia
  Garnett
  Yon
  Domonique
  Norma
  Marcus
  Billi
  Valentine
  Hang
  Charlena
  Lan
  Miles
  Carry
  Shante
  Blaine
  Eveline
  Shantell
  Drucilla
  Debera
  Alphonse
  Georgianna
  Gertrude
  Everette
  Frederick
  Delilah
  Markita
  Walton
  Lyndsay
  Keesha
  Hong
  Florencio
  Sue
  Adelaide
  Craig
  Stanford
  Zoila
  Leslie
  Solomon
  Verdell
  Alexandria
  Hayden
  Roseanne
)

# --- Create Semesters
fall_semester = Semester.create!(
  :name => Semester::FALL, 
  :year => "2012", 
  :start_date => Date.today - 10, 
  :end_date => Date.today + 10,
  :registration_deadline => Deadline.new(
    :title => "Registraiton Deadline",
    :summary => "You must have you preferences selected by this deadline",
    :due_date => Date.today + 5,
  ),
  :status => Semester::PUBLIC,
)

spring_semester = Semester.create!(
  :name => Semester::SPRING, 
  :year => "2012", 
  :start_date => Date.today - 20, 
  :end_date => Date.today - 10,
  :registration_deadline => Deadline.new(
    :title => "Registraiton Deadline",
    :summary => "You must have your preferences selected by this deadline",
    :due_date => Date.today - 20,
  ),
  :status => Semester::PUBLIC,
)

# --- Create Advisor
user = User.new({:first_name => 'Sangyoon',
                 :last_name => 'Park',
                 :street_address => '346 soda UC Berkeley',
                 :city => 'Berkeley',
                 :state => 'CA',
                 :zipcode => '94000',
                 :phone_number => '123-456-7890',
                 :email => 'advisor@advisor.com',
:password => '1234',
:password_confirmation => '1234'})
owner = User.build_owner("Advisor")
user.owner = owner
user.save
owner.save

# --- Create Cal Faculties
(1..10).each do |i|
  user = User.new({:first_name => "Cal Faculty#{i}",
		   :last_name => "Last#{i}",
                   :street_address => 'myaddr',
                   :phone_number => '000-000-0000',
                   :email => "CalFacultyEmail#{i}@gmail.com",
                   :password => '1234',
                   :password_confirmation => '1234'})
  owner = User.build_owner("CalFaculty")
  user.owner = owner
  user.save
  owner.save
  owner.semesters = Semester.all
  Semester.all.each do |sem|
    sem.cal_facultys << owner
  end
end

# --- Create districts
busd = District.create!(:name => "BUSD")
ousd = District.create!(:name => "OUSD")
wccusd = District.create!(:name => "WCCUSD")
emery_unified = District.create!(:name => "Emery Unified")
alameda_county = District.create!(:name => "Alameda County Office of Education")

# --- Create schools
School.create!(:district => busd, :level => HIGH_SCHOOL, :name => "Berkeley High")
School.create!(:district => busd, :level => MIDDLE_SCHOOL, :name => "Longfellow")
School.create!(:district => busd, :level => MIDDLE_SCHOOL, :name => "Willard")
School.create!(:district => busd, :level => MIDDLE_SCHOOL, :name => "Martin Luther King")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Cragmont")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Jefferson")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Washington")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Berkeley Arts Magnet")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Le Conte")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Thousand Oaks")
School.create!(:district => busd, :level => ELEMENTARY_SCHOOL, :name => "Jefferson")
School.create!(:district => ousd, :level => HIGH_SCHOOL, :name => "Oakland High")
School.create!(:district => ousd, :level => ELEMENTARY_SCHOOL, :name => "Chabot")
School.create!(:district => ousd, :level => MIDDLE_SCHOOL, :name => "Edna Brewer")
School.create!(:district => ousd, :level => MIDDLE_SCHOOL, :name => "Madison")
School.create!(:district => ousd, :level => ELEMENTARY_SCHOOL, :name => "New Highland Academy")
School.create!(:district => ousd, :level => ELEMENTARY_SCHOOL, :name => "Joaquin Miller")
School.create!(:district => ousd, :level => HIGH_SCHOOL, :name => "Oakland International")
School.create!(:district => ousd, :level => HIGH_SCHOOL, :name => "Life Academy")
School.create!(:district => ousd, :level => HIGH_SCHOOL, :name => "Skyline High")
School.create!(:district => ousd, :level => MIDDLE_SCHOOL, :name => "Westlake")
School.create!(:district => ousd, :level => ELEMENTARY_SCHOOL, :name => "Markham")
School.create!(:district => ousd, :level => HIGH_SCHOOL, :name => "Arise")
School.create!(:district => emery_unified, :level => MIDDLE_SCHOOL, :name => "Anna Yates")
School.create!(:district => emery_unified, :level => HIGH_SCHOOL, :name => "Emery Secondary")
School.create!(:district => alameda_county, :level => HIGH_SCHOOL, :name => "California College Preparatory Academy")
School.create!(:district => wccusd, :level => HIGH_SCHOOL, :name => "El Cerrito High")
School.create!(:district => wccusd, :level => ELEMENTARY_SCHOOL, :name => "Harding")
School.create!(:district => wccusd, :level => ELEMENTARY_SCHOOL, :name => "Edward M. Downer")
School.create!(:district => wccusd, :level => MIDDLE_SCHOOL, :name => "Helms")

# --- Create courses
high_school_courses = [
  "Physics", 
  "Geometry", 
  "Algebra 1", 
  "Algebra 2", 
  "Statistics", 
  "Integrated Math", 
  "Calculus", 
  "Integrated Science", 
  "Environmental Science", 
  "Advanced Biology", 
  "Integrated Biology", 
  "Bio Tech", 
  "Biology", 
  "Antatomy", 
  "AP Biology", 
  "AP Calculus", 
  "Math Analysis", 
  "Advanced Algebra", 
  "Pre Calculus", 
  "AP Calculus", 
]

high_school_courses.each do |name|
  Course.create!(:name => name, :grade => HIGH_SCHOOL)
end

Course.create!(:name => "Math", :grade => "6")
Course.create!(:name => "Math", :grade => "7")
Course.create!(:name => "Math", :grade => "8")
Course.create!(:name => "Science", :grade => "6")
Course.create!(:name => "Science", :grade => "7")
Course.create!(:name => "Science", :grade => "8")
Course.create!(:name => "Pre Algebra", :grade => "6")

# --- Create Students
users = (1..20).map { |i| "student#{i}@test.com" } # ["student1@test.com", "student2@test.com", "student3@test.com", "student4@test.com"]
users.each_with_index do |u, i|
    user = User.new({:first_name => names[i % names.size],
                   :last_name => names[(i + 10) % names.size],
                   :street_address => '346 soda UC Berkeley',
                   :city => 'Berkeley',
                   :state => 'CA',
                   :zipcode => '94000',
                   :phone_number => '123-456-7890',
                   :email => u,
                   :password => '1234',
                   :password_confirmation => '1234'})
  owner = User.build_owner("Student")
  owner.save!
  owner.semesters = Semester.all
  Semester.all.each do |sem|
    sem.students << owner
  end
  user.owner = owner
  user.save
  owner.save
end

# --- Create Students part 2
(1..10).each do |i|
  user = User.new({
                   :first_name => names[i % names.size],
    	           :last_name => names[(i + 6) % names.size],
                   :street_address => 'myaddr',
                   :phone_number => '000-000-0000',
                   :email => "StudentEmail#{i}@gmail.com",
                   :password => '1234',
                   :password_confirmation => '1234'})
  owner = User.build_owner("Student")
  owner.save!
  owner.semesters = Semester.all
  Semester.all.each do |sem|
    sem.students << owner
  end
  user.owner = owner
  user.save!
end

# --- Create mentor teachers
(1..10).each do |i|
  user = User.new({
                   :first_name => names[(i + 2)% names.size],
    	           :last_name => names[(i + 13) % names.size],
                   :street_address => 'myaddr',
                   :phone_number => '000-000-0000',
                   :email => "TeacherEmail#{i}@gmail.com",
                   :password => '1234',
                   :password_confirmation => '1234'
  })
  owner = MentorTeacher.create(:user => user, :school => School.all[i % School.all.size], :semesters => Semester.all)
  user.owner = owner
  user.save!
  Semester.all.each do |sem|
    sem.mentor_teachers << owner
  end
end

# --- Create Cal Courses
# CalCourse(id: integer, name: string, timeslots: text, school_type: string,
# course_grade: string, created_at: datetime, updated_at: datetime)
cal_courses = [
  'UGIS 80A',
  'UGIS 80B',
  'ED 130',
  'ED 195C',
  'UGIS 187',
  'UGIS 81A',
  'MATH 197',
]

cal_courses.each.with_index do |c, i|
  sem = Semester.all[i % Semester.all.size]
  cal_course = CalCourse.create!(:name => c, :semester => sem, :school_type => "Middle School")
  sem.cal_courses << cal_course
end


# --- Create timeslots
times = [["10:00 AM", "11:00 AM"], ["12:00 PM", "1:30 PM"], ["11:00 AM", "12:30 PM"],
         ["4:00 PM", "5:00 PM"]]


Timeslot.weekdays.each do |day|
  times.each.with_index do |time, i|
#    i += 1
    start_time, end_time = time
    teachers = MentorTeacher.all
    timeslot = Timeslot.create!(
                                :start_time => start_time, 
                                :end_time => end_time,
                                :mentor_teacher => teachers[i % teachers.length], 
                                :day => day, 
                                :course => Course.all[i % Course.all.size],
                                ) 
    end
  end

Timeslot.all.each_with_index do |t, i|
  # assign timeslots to each cal course
  CalCourse.all[i % CalCourse.count].timeslots << t #if i%3 != 0
end

# --- Create preferences
#Timeslot.all.each.with_index do |ts, i|
# Preference.create!(:timeslot => ts, :student => Student.all[i % Student.all.size], :ranking => i)
#end

Student.all.each_with_index do |t, i|
  # assign students to each cal course
  #CalCourse.all[i % CalCourse.all.size].students<< t
  # assign students to each timeslot
  #Timeslot.all[i % Timeslot.all.size].students << t
end

Timeslot.all.each_with_index do |t, i|
  # assign timeslots to each teacher
  timeslots = MentorTeacher.all[i % MentorTeacher.all.size].timeslots 
  timeslots << t
end


# Timeslot.all.each_with_index do |t, i|
#   # assign placements to each student
#   Student.all[i % Student.all.size].placements << t
# end


# --- Give student 1 an assignment
# student = Student.find(1)
# student.placements << Timeslot.where(:day => Timeslot.day_index(:monday))[0]
# student.cal_courses << CalCourse.all[0]
# student.save!


# --- Add relations for cal_faculties and cal_courses
CalCourse.all.each_with_index do |t, i|
  # assign cal course to each cal_faculty
  #CalFaculty.all[i % CalFaculty.all.size].cal_courses<< t
  #CalFaculty.all[(i+7) % CalFaculty.all.size].cal_courses<< t
end
