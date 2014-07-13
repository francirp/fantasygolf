require 'open-uri'

class Golfer < ActiveRecord::Base

  has_many :competitors
  has_many :tournaments, through: :competitors

end
