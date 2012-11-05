FactoryGirl.define do
  factory :student do
    preferences {|p| [p.association(:preference)]}
  end
end
