# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::Getter::Type3 do
  subject(:service) { described_class.new(cache_path: 'spec/fixtures/type3') }

  let(:result) do
    {
      'cards' => [
        {
          'colors' => %w[Red Blue],
          'name'   => 'Master the Way',
          'set'    => 'KTK'
        }
      ]
    }
  end

  it 'returns correct result' do
    expect(subject.call).to eq(result)
  end
end
