# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :semester do
    name "Fall"
    year 2001
    status "Public"
    start_date "2012-11-23"
    end_date "2012-11-23"

    association :registration_deadline, factory: :deadline
  end
end
