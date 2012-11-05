# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "Math"
    grade "1"
    timeslots =  { FactoryGirl.generate(:timeslot) }
  end
end
