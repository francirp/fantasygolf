class Tournament < ActiveRecord::Base
  has_many :competitors
  has_many :golfers, through: :competitors

  def refresh_leaderboard
    Scrapers::Yahoo::Leaderboard.new(tournament: self, url: url).refresh
  end

  def update_par
    Scrapers::Yahoo::Leaderboard.new(tournament: self, url: url).update_par
  end

  def self.set_start_dates
    where(start_date: nil).each do |tournament|
      tournament.set_start_date
    end
  end

  def self.set_par
    where(par: nil).each do |tournament|
      tournament.set_par
    end
  end

  def set_start_date
    self.start_date = Scrapers::Yahoo::Leaderboard.new(tournament: self).start_date
    self.save
  end

  def set_par
    self.par = Scrapers::Yahoo::Leaderboard.new(tournament: self).par
    self.save
  end

end
