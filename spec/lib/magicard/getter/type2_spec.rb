# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::Getter::Type2 do
  subject(:service) { described_class.new(cache_path: 'spec/fixtures/type2') }

  let(:result) do
    {
      '10E' => {
        'Common'   => [
          {
            'name'   => 'Angel of Mercy',
            'rarity' => 'Common',
            'set'    => '10E'
          }
        ],
        'Uncommon' => [
          {
            'name'   => "Ancestor's Chosen",
            'rarity' => 'Uncommon',
            'set'    => '10E'
          },
          {
            'name'   => 'Mindswipe',
            'rarity' => 'Uncommon',
            'set'    => '10E'
          }
        ]
      },
      '4ED' => {
        'Common' => [
          {
            'name'   => 'Divine Transformation',
            'rarity' => 'Common',
            'set'    => '4ED'
          }
        ]
      }
    }
  end

  it 'returns correct result' do
    expect(subject.call).to eq(result)
  end
end
