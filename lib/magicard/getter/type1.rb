# frozen_string_literal: true

module Magicard
  module Getter
    class Type1
      include ActsAsGetter

      def call
        process_card({}) do |card, result|
          set = card['set']

          result[set] ||= []
          result[set] << card
        end
      end
    end
  end
end
