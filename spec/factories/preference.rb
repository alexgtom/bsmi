FactoryGirl.define do
  factory :preference do
    ranking 1
    association :timeslot, factory: :timeslot
  end
end
