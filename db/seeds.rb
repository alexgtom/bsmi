# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Create timeslots

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

user = User.new({:name => 'Sangyoon Park',
                 :address => '346 soda UC Berkeley, United States',
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
  user = User.new({:name => u,
                   :address => 'myaddr',
                   :phone_number => '000-000-0000',
                   :email => u,
                   :password => '1234',
                   :password_confirmation => '1234'})
  owner = User.build_owner("Student")
  user.owner = owner
  user.save
  owner.save
end
