# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cal_course do
    name "MyString"
#    timeslots { FactoryGirl.generate(:timeslot) }
#    courses  { FactoryGirl.generate(:course) }
  end
end
