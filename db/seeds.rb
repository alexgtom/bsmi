# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# --- Create timeslots

(1..10).each do |i|
  Student.create!   
end

(1..10).each do |i|
  MentorTeacher.create!   
end

times = [["10:00 AM", "10:30 AM"], ["12:00 PM", "1:30 PM"], ["11:00 AM", "12:30 PM"],
         ["4:00 PM", "5:00 PM"]]
[:monday, :tuesday, :wednesday, :thursday, :friday].each do |day|
  times.each.with_index do |time, i|
    i += 1
    start_time, end_time = time
    Timeslot.create!(:start_time => start_time, :end_time => end_time,
                     :mentor_teacher => MentorTeacher.find(i), :day => day)  
  end
end

Timeslot.all.each.with_index do |ts, i|
  i += 1
  if (i < Student.count)
    Preference.create!(:timeslot => ts, :student => Student.find(i), :ranking => i)
  end
end         

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

users = ["student1@test.com", "student2@test.com", "student3@test.com", "student4@test.com"]
users.each do |u|
  user = User.new({:first_name => u,
                   :last_name => 'Anon',
                   :street_address => '346 soda UC Berkeley',
                   :city => 'Berkeley',
                   :state => 'CA',
                   :zipcode => '94000',
                   :phone_number => '123-456-7890',
                   :email => u,
                   :password => '1234',
                   :password_confirmation => '1234'})
  owner = User.build_owner("Student")
  user.owner = owner
  user.save
  owner.save
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
