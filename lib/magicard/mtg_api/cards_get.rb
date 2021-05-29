# frozen_string_literal: true

require 'net/http'

module Magicard
  module MtgApi
    class HttpError < StandardError; end

    module CardsGet
      extend self

      URL = 'https://api.magicthegathering.io/v1/cards'

      def call(page = 1)
        uri = URI("#{URL}?page=#{page}")
        res = Net::HTTP.get_response(uri)

        raise(HttpError, res.message) unless res.is_a?(Net::HTTPSuccess)

        {
          content:             res.body,
          cards_total:         res['Total-Count'].to_i,
          remaining_ratelimit: res['Ratelimit-Remaining'].to_i
        }
      end
    end
  end
end
