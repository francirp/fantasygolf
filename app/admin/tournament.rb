ActiveAdmin.register Tournament do

  config.sort_order = "start_date_asc"

  permit_params :name, :event_type, :purse, :winning_share, :points, :start_date, :end_date, :venue_id, :year,

  index do
    selectable_column
    keys = Tournament.new.attributes.keys
    keys = keys - ["created_at", "updated_at"]
    keys.each do |attr|
      column attr
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :par
      row :start_date
      row :url
    end

    panel("Leaderboard For This Tournament") do
      table_for(tournament.competitors.includes(:golfer)) do
        column :rank
        column "Name" do |competitor|
          link_to competitor.golfer.name, admin_competitor_path(competitor)
        end
        4.times do |i|
          column "Round #{i + 1} Score" do |competitor|
            competitor.scores[i]
          end
        end
        4.times do |i|
          column "Round #{i + 1} vs Par" do |competitor|
            competitor.score_vs_par(score: competitor.scores[i])
          end
        end
      end
    end
  end

end
