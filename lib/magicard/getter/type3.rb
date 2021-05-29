# frozen_string_literal: true

module Magicard
  module Getter
    class Type3
      include ActsAsGetter

      def call
        process_card({ 'cards' => [] }) do |card, result|
          set    = card['set']
          colors = card['colors']

          next if set != 'KTK' || colors.nil? || colors.sort != %w[Red Blue].sort

          result['cards'] << card
        end
      end
    end
  end
end
