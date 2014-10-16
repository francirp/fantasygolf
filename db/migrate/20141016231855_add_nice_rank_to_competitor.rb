class AddNiceRankToCompetitor < ActiveRecord::Migration
  def change
    add_column :competitors, :rank_num, :integer
  end
end
