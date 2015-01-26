MODELS = [Tournament, Venue, Course, Hole, Golfer, Competitor]
MODELS.each do |model|
  name = model.name
  model.destroy_all
  puts "Successfully destroyed #{name} data."
end

SportsDataApiWrapper::Season.new(year: 2015).sync_to_db

MODELS.each do |model|
  puts "There are now #{model.count} #{model.name.pluralize} in the database"
end