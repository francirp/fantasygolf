class UpgradeTournamentsForApi < ActiveRecord::Migration
  def change
    remove_column :tournaments, :par
    remove_column :tournaments, :url
    add_column :tournaments, :sports_data_api_id, :string
    add_column :tournaments, :event_type, :string
    add_column :tournaments, :purse, :float
    add_column :tournaments, :winning_share, :float
    add_column :tournaments, :end_date, :date
    add_column :tournaments, :venue_id, :integer
    add_column :tournaments, :year, :integer
  end
end
