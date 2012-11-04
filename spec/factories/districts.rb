# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :district do 
    sequence :name do |n|
      "district#{n}"
    end
  end
end
