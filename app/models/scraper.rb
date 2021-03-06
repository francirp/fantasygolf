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

  def self.currency_to_float(currency)
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
