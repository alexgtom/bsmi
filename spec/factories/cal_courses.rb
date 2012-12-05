# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cal_course do
    sequence :name do |n| 
      "course#{n}"
    end

    school_type "Elementary School"
    
    
    association :semester, factory: :semester
  end
end
