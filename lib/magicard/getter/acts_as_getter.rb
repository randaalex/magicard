# frozen_string_literal: true

require 'json'

# Concern adds getter logic (checking and reading cache) to class
# implements `process_card` method which accepts iterator and block
#
# Example
#   class A
#     include ActsAsGetter
#
#     def call
#       process_card([]) do |card, result|
#         result << card
#       end
#     end

module Magicard
  module Getter
    module ActsAsGetter
      PAGE_JSON_PREFIX = 'cards'

      def initialize(cache_path:)
        @cache_path = cache_path
      end

      private def process_card(object, &block)
        cached_pages = Dir.glob("#{@cache_path}/*.json")

        raise Magicard::Error, 'Local cache not found. Please run `bin/magicard load`' if cached_pages.empty?

        cached_pages.each do |filename|
          File.open(filename) do |cards_file|
            cards_data = JSON.parse(cards_file.read)

            cards_data[PAGE_JSON_PREFIX].each do |card_data|
              block.call(card_data, object)
            end
          end
        end

        object
      end
    end
  end
end
