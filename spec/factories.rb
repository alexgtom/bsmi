
require 'factory_girl'
require 'time'
FactoryGirl.define do
  factory :mentor_teacher do
  
    sequence :school do |n|
      school 'school#{n}'
    end

    user #Generates a new user for this teacher
  end  

  sequence :name { |n| "user#{n}" }
  factory :user do
    name { FactoryGirl.generate(:name) }

    email { '#{name}@bsmi.org' }
    password { name }

    phone_number '111-111-1111'
    address '111 St Way'

  end

  #Returns a time between a given start hour and an end hour, with a certain number
  #of slots per hour. Each of these parameters is specifiable and has a reasonable
  #default.
  #Options:
  #  :start_hour : Earliest hour at which a time can be generated
  #  :end_hour : Latest hour at which a time can be generated
  #  :num_hours : The number of possible hours in which a timeslot can be placed
  #     Overrides end_hour if provided.
  #  :slots_per_hour : The number of timeslots we can pack into 1 hour.
  
  def make_time(n, options={})
    start_hour = options[:start_hour] || 8
    end_hour = options[:end_hour] || 16
    num_hours = options[:num_hours] || (end_hour - start_hour).abs
    slots_per_hour = options[:slots_per_hour] || 4

      num_slots = slots_per_hour * num_hours
      slot_length = 60 / slots_per_hour
      slot_num = n % num_slots
      
      seconds_since_start = slot_num * slot_length * 60
      return Time.parse("#{start_hour}:00") + seconds_since_start
    end


  sequence :time do |n|
    #New timeslot every 2 hours
    make_time(n, :slots_per_hour => 0.5)
  end


  factory :timeslot do    
    sequence :day do |n|
      day Timeslot.weekdays[n % 5]
    end
    
    start_time { FactoryGirl.generate(:time) }
    end_time {start_time + 3600} #One hour after

    sequence :num_assistants do |n|
      n % 2
    end
  end

  

  factory :student do
    preferences {|p| [p.association(:preference)]}
  end

  factory :preference do
    ranking 1
    association :timeslot, factory: :timeslot
  end

end
