class AddPointsToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :points, :float
  end
end
