FactoryGirl.define do

  sequence :user_name do |n| 
    "user#{n}"
  end
  factory :user do
    first_name { FactoryGirl.generate(:user_name) }
    last_name { FactoryGirl.generate(:user_name) }
    email { "#{name}@bsmi.org" }
    password { name }
    password_confirmation { password }
    phone_number '111-111-1111'
    street_address '111 St Way'

  end
end
