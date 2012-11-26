# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deadline do
    title "MyString"
    summary "MyText"
    due_date "2012-11-24 02:30:13"
  end
end
