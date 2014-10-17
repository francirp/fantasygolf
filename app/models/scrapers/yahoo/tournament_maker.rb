require 'open-uri'

module Scrapers
  module Yahoo
    class TournamentMaker

      DEFAULT_ROOT_URL = "http://sports.yahoo.com"

      attr_reader :parsed_css, :doc

      def initialize(args = {})
        @parsed_css = args[:parsed_css]
        @doc = Nokogiri::HTML(open(@url))
      end

      def create
        Tournament.find_by_url(url) || Tournament.create(url: url, name: name)
      end

      def path
        parsed_css.attr('value')
      end

      def url
        "#{DEFAULT_ROOT_URL}#{path}"
      end

      def name
        parsed_css.text
      end

    end
  end
end
