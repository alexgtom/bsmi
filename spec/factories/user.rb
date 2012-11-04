FactoryGirl.define do

  sequence :user_name do |n| 
    "user#{n}"
  end
  factory :user do
    name { FactoryGirl.generate(:user_name) }

    email { "#{name}@bsmi.org" }
    password { name }
    password_confirmation { name }
    phone_number '111-111-1111'
    address '111 St Way'

  end
end
