# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cal_course do
    name "MyString"
    timeslots "1, 2, 3"
    school_type "MyString"
    course_grade "MyString"
    courses  { FactoryGirl.generate(:course) }
  end
end
