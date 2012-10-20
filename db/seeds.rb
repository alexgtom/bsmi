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

times.each.with_index do |time, i|
  i += 1
  start_time, end_time = time
  Timeslot.create!(:start_time => start_time, :end_time => end_time,
                   :mentor_teacher => MentorTeacher.find(i), :day => :monday)  
end

Timeslot.all.each.with_index do |ts, i|
  i += 1
  if (i < Student.count)
    Preference.create!(:timeslot => ts, :student => Student.find(i), :ranking => i)
  end
end         
         
