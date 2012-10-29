
require 'factory_girl'

FactoryGirl.define do
  factory :mentor_teacher do
    sequence :email do |n|
      email 'teacher#{n}@teacher.com'
    end

    password 'teacher'

    sequence :school do |n|
      school 'school#{n}'
    end

    phone_number '111-111-1111'
    mailing_address '111 St Way'
  end  

  factory :timeslot do
    day :monday   # monday
  end

  factory :student do
    preferences {|p| [p.association(:preference)]}
  end

  factory :preference do
    ranking 1
    association :timeslot, factory: :timeslot
  end
end
