require 'open-uri'

class Golfer < ActiveRecord::Base

  has_many :competitors
  has_many :tournaments, through: :competitors

  COLUMNS_REFERENCE = {
    "Rk" => :rank,
    "Golfer" => :name
  }

  def self.refresh_golfers
    url = "http://sports.yahoo.com/golf/pga/stats/bycategory?cat=WORLD_RANK&season=2014"
    doc = Nokogiri::HTML(open(url))
    links = doc.css('table.sportsTable td.player a')
    links.each do |link|
      # link = row.css('td.player a')
      profile_url = link.attr('href')
      profile_id = yahoo_id_from_url(profile_url)
      golfer = Golfer.find_by_profile_id(profile_id) || Golfer.new(profile_id: profile_id)
      golfer.name = link.text
      # golfer.rank = row.css('td.rank').text
      golfer.save
    end
  end

  # def self.refresh_golfers
  #   indexes = column_indexes
  #   range = ('a'..'z').to_a
  #   range.each do |letter|
  #     url = "http://sports.yahoo.com/golf/pga/players?lname=#{letter}"
  #     doc = Nokogiri::HTML(open(url))
  #     tds = doc.css('#playerResult table td')
  #     tds.each do |td|
  #       if td.css('a')
  #         link = td.css('a')
  #         profile_url = link.attr('href').value
  #         profile_id = yahoo_id_from_url(profile_url)
  #         golfer = Golfer.find_by_profile_id(profile_id) || Golfer.new(profile_id: profile_id)
  #         golfer.name = link.text
  #         golfer.save
  #       end
  #     end
  #   end
  # end

  def self.column_indexes
    url = "http://www.cbssports.com/golf/rankings/world-rankings"
    doc = Nokogiri::HTML(open(url))
    rows = doc.css('table.data tr.label')
    row = rows.first
    indexes = {}
    row.css('td').each_with_index do |td, index|
      column = COLUMNS_REFERENCE[td.text]
      if column.present?
        indexes[column] = index
      end
    end
    return indexes
  end

  def self.cbs_id_from_url(url)
    url.split("/")[-2]
  end

  def self.yahoo_id_from_url(url)
    url.split("/")[-1]
  end

end
