# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sports_data_api_id "MyString"
    name "MyString"
    yardage 1
    par 1
    holes ""
  end
end
