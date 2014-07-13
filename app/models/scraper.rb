require 'open-uri'

class Scraper

  def self.refresh_golfers
    url = "http://sports.yahoo.com/golf/pga/stats/bycategory?cat=WORLD_RANK&season=2014"
    doc = Nokogiri::HTML(open(url))
    links = doc.css('table.sportsTable td.player a')
    links.each do |link|
      # link = row.css('td.player a')
      profile_url = link.attr('href')
      profile_id = yahoo_id_from_url(url: profile_url, spots: -1)
      golfer = Golfer.find_by_profile_id(profile_id) || Golfer.new(profile_id: profile_id)
      golfer.name = link.text
      # golfer.rank = row.css('td.rank').text
      golfer.save
    end
  end

  def self.refresh_leaderboard(args = {})
    url = args[:url]
    tournament = args[:tournament]
    doc = Nokogiri::HTML(open(url))
    rows = doc.css("#leaderboardtable tbody tr")
    rows.each do |row|
      link = row.css('td.player a')
      profile_url = link.attr('href').value
      profile_id = yahoo_id_from_url(url: profile_url, spots: 5)
      golfer = Golfer.find_by_profile_id(profile_id)
      unless golfer
        golfer = Golfer.new(profile_id: profile_id)
        golfer.name = link.text
        golfer.save
      end
      competitor = tournament.competitors.build(golfer_id: golfer.id)
      competitor.rank = row.css('.position').text.to_i
      earnings = row.css('.earnings').text
      earnings_formatted = currency_to_float(earnings) if earnings
      competitor.earnings = earnings_formatted
      competitor.save
    end
  end

  def pull_tournaments
    url = "http://sports.yahoo.com/golf/pga/leaderboard"
    doc = Nokogiri::HTML(open(url))
    options = doc.css("select[name='tour_event'] option")
    options.each do |option|
      path = option.attr('value')
      name = option.text
      tournament = Tournament.new(url: "http://sports.yahoo.com#{path}", name: name)
      tournament.save
    end
  end

  def currency_to_float(currency)
    currency.scan(/\d|[.]/).join.to_f
  end

  def self.yahoo_id_from_url(args = {})
    url = args[:url]
    spots = args[:spots]
    url.split("/")[spots]
  end

  def to_i(position)
    position.remove("T")
  end
end
