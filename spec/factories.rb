FactoryGirl.define do
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
