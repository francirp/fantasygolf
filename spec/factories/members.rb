# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    user_id 1
    league_id 1
    role "MyString"
  end
end
