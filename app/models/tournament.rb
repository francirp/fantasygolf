class Tournament < ActiveRecord::Base
  has_many :competitors
  has_many :golfers, through: :competitors

  def refresh_leaderboard
    Scrapers::Yahoo::Leaderboard.new(tournament: self, url: url).refresh
  end

  def update_par
    Scrapers::Yahoo::Leaderboard.new(tournament: self, url: url).update_par
  end

end
