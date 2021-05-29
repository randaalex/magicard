# frozen_string_literal: true

module Magicard
  module Getter
    class Type2
      include ActsAsGetter

      def call
        process_card({}) do |card, result|
          set    = card['set']
          rarity = card['rarity']

          result[set] ||= {}
          result[set][rarity] ||= []

          result[set][rarity] << card
        end
      end
    end
  end
end
