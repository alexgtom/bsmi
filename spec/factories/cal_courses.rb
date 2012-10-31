# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cal_course do
    name "MyString"
    timeslots "MyText"
    school_type "MyString"
    course_grade "MyString"
  end
end
