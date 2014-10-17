module Scrapers
  module Yahoo
    class DateParser

      attr_accessor :raw_date

      def initialize(raw_date = nil, args = {})
        @raw_date = raw_date
      end

      def date_text
        @date_text ||= raw_date.split("(").last
      end

      def month
        abbreviation = date_text[0..2].downcase
        abbreviations_to_num[abbreviation]
      end

      def start_day
        date_text.split("-").first.scan(/\d/).join("").to_i
      end

      def end_day
        date_text.split("-").last.split(",").first.to_i
      end

      def year
        y = date_text[-5..-1].to_i
        return y if [Date.today.year, Date.today.year + 1].include?(y)
        return Date.today.year
      end

      def date
        Date.new(year, month, start_day)
      end

      def abbreviations_to_num
        hash = {}
        Date::MONTHNAMES.compact.each_with_index do |month_name, index|
          abbreviation = month_name[0..2].downcase
          hash[abbreviation.downcase] = index + 1
        end
        # {"jan"=>1, "feb"=>2, "mar"=>3, "apr"=>4, "may"=>5, "jun"=>6, "jul"=>7, "aug"=>8, "sep"=>9, "oct"=>10, "nov"=>11, "dec"=>12}
        hash
      end

    end
  end
end
