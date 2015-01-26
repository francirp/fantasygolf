class UpdateGolferTable < ActiveRecord::Migration
  def change
    # tournament updates
    add_column :tournaments, :status, :string
    add_column :tournaments, :coverage, :string

    # remove old golfer attributes
    remove_column :golfers, :rank
    remove_column :golfers, :profile_id

    # add new golfer attributes
    add_column :golfers, :sports_data_api_id, :string
    add_column :golfers, :first_name, :string
    add_column :golfers, :last_name, :string
    add_column :golfers, :height, :integer
    add_column :golfers, :weight, :integer
    add_column :golfers, :birthday, :date
    add_column :golfers, :country, :string
    add_column :golfers, :residence, :string
    add_column :golfers, :birth_place, :string
    add_column :golfers, :member, :boolean
    add_column :golfers, :updated, :date
    add_column :golfers, :college, :string
    add_column :golfers, :turned_pro, :integer
    add_column :golfers, :seed, :integer
    add_column :golfers, :ball_maker, :string
    add_column :golfers, :club_maker, :string
    add_column :golfers, :drive_avg, :float
    add_column :golfers, :cuts_made, :integer
    add_column :golfers, :cuts, :integer
    add_column :golfers, :drive_acc, :float
    add_column :golfers, :earnings_rank, :integer
    add_column :golfers, :events_played, :integer
    add_column :golfers, :points_rank, :integer
    add_column :golfers, :points, :integer
    add_column :golfers, :first_place, :integer
    add_column :golfers, :gir_pct, :float
    add_column :golfers, :hole_proximity_avg, :float
    add_column :golfers, :scoring_avg, :float
    add_column :golfers, :scrambling_pct, :float
    add_column :golfers, :earnings, :float
    add_column :golfers, :second_place, :integer
    add_column :golfers, :strokes_gained, :float
    add_column :golfers, :third_place, :integer
    add_column :golfers, :top_10, :integer
    add_column :golfers, :top_25, :integer
    add_column :golfers, :withdrawals, :integer
    add_column :golfers, :world_rank, :integer
  end
end
