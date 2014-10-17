require 'open-uri'

module Scrapers
  module Yahoo
    class Tournaments

      attr_reader :url, :doc

      def initialize(args = {})
        @url = args.fetch(:url, "http://sports.yahoo.com/golf/pga/leaderboard/2014/15")
        @doc = Nokogiri::HTML(open(@url))
      end

      def options
        doc.css("select[name='tour_event'] option")
      end

      def pull_tournaments
        options.each do |option|
          TournamentMaker.new(parsed_css: option).create
        end
      end

    end

  end
end
