# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    sports_data_api_id "MyString"
    name "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
    country "MyString"
  end
end
