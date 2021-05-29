# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::Getter::Type1 do
  subject(:service) { described_class.new(cache_path: 'spec/fixtures/type1') }

  let(:result) do
    {
      '10E' => [
        {
          'name' => "Ancestor's Chosen",
          'set'  => '10E'
        },
        {
          'name' => 'Angel of Mercy',
          'set'  => '10E'
        }
      ],
      '4ED' => [
        {
          'name' => 'Divine Transformation',
          'set'  => '4ED'
        }
      ]
    }
  end

  it 'returns correct result' do
    expect(subject.call).to eq(result)
  end
end
