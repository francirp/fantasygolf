class Tournament < ActiveRecord::Base
  has_many :competitors
  has_many :golfers, through: :competitors

end
