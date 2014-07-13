require 'open-uri'

class Scraper

  INDEXES = {
    :rank => 1,
    :golfer_name => 3,
    :earnings => 4
  }

  def refresh_leaderboard(args = {})
    url = args[:url]
    tournament = args[:tournament]
    doc = Nokogiri::HTML(open(url))
    rows = doc.css("#leaderboardtable tbody tr")
    rows.each do |row|
      link = row.css('td.player a')
      profile_url = link.attr('href').value
      profile_id = Scraper.yahoo_id_from_url(profile_url)
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

  def self.yahoo_id_from_url(url)
    url.split("/")[5]
  end

  def to_i(position)
    position.remove("T")
  end
end
