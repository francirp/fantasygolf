class AddVenueIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :venue_id, :integer
  end
end
