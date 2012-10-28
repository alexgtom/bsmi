# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    sequence :name do |n|
      "school#{n}"
    end

    district
    
    level School::LEVEL[0]
  end
end
