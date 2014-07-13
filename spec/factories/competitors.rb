# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competitor do
    golfer_id 1
    tournament_id 1
    rank 1
    earnings 1.5
  end
end
