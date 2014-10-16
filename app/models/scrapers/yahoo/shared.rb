module Scrapers
  module Yahoo
    module Shared

      def yahoo_id_from_url(args = {})
        url = args[:url]
        spots = args[:spots]
        url.split("/")[spots]
      end

      def currency_to_float(currency)
        currency.scan(/\d|[.]/).join.to_f
      end

    end
  end
end
