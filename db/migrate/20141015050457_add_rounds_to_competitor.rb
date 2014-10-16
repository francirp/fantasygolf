class AddRoundsToCompetitor < ActiveRecord::Migration
  def change
    add_column :competitors, :scores, :text
  end
end
