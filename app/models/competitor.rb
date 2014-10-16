class Competitor < ActiveRecord::Base
  belongs_to :golfer
  belongs_to :tournament

  serialize :scores, Array

  default_scope { order(:rank_num) }

  def self.by_rank
    yield sort_by(&:nice_rank)
  end

  def score_vs_par(args = {})
    score = args[:score]
    score - tournament.par
  end

end
