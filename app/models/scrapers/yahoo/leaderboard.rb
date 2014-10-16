require 'open-uri'

module Scrapers
  module Yahoo
    class Leaderboard

      attr_reader :url, :doc, :rows
      attr_accessor :tournament

      def initialize(args = {})
        @url = args[:url]
        @tournament = args[:tournament]
      end

      def doc
        @doc ||= Nokogiri::HTML(open(url))
      end

      def rows
        @rows ||= doc.css("#leaderboardtable tbody tr")
      end

      def par
        doc.css("#leaderboard .par span").text.to_i
      end

      def refresh
        rows.each do |row|
          LeaderboardCompetitor.new(row: row, tournament: tournament).refresh
        end
        update_par
      end

      def update_par
        tournament.par = par
        tournament.save
      end

    end

    class LeaderboardCompetitor
      include Shared

      attr_reader :row, :tournament

      def initialize(args = {})
        @row = args[:row]
        @tournament = args[:tournament]
      end

      def link
        row.css('td.player a')
      end

      def profile_url
        link.attr('href').value
      end

      def profile_id
        yahoo_id_from_url(url: profile_url, spots: 5)
      end

      def golfer
        @golfer ||= (Golfer.find_by_profile_id(profile_id) || create_golfer)
      end

      def create_golfer
        g = Golfer.new(profile_id: profile_id)
        g.name = link.text
        g.save
      end

      def earnings
        e = row.css('.earnings').text
        currency_to_float(e) if e
      end

      def rank
        row.css('.position').text
      end

      def rank_num
        rank.gsub("T", "").to_i
      end

      def scores
        4.times.map {|i| row.css("td")[i + 2].text.strip.to_i }.to_a
      end

      def refresh
        competitor = tournament.competitors.find_by_golfer_id(golfer.id) || tournament.competitors.build(golfer_id: golfer.id)
        competitor.update_attributes(earnings: earnings, rank: rank, rank_num: rank_num, scores: scores)
      end

    end

  end
end
