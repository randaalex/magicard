# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::MtgApi::CardsGet do
  let(:page) { 2 }

  context 'successful http response' do
    let(:service_result) do
      {
        cards_total:         100,
        content:             'content',
        remaining_ratelimit: 200
      }
    end

    before do
      stub_request(:get, "https://api.magicthegathering.io/v1/cards?page=#{page}").and_return(
        status:  200,
        body:    'content',
        headers: {
          'Total-Count'         => 100,
          'Ratelimit-Remaining' => 200
        }
      )
    end

    it 'returns correct response' do
      expect(described_class.call(page)).to match(service_result)
    end
  end

  context 'unsuccessful http response' do
    before do
      stub_request(:get, "https://api.magicthegathering.io/v1/cards?page=#{page}").and_return(status: 500)
    end

    it 'raises exception' do
      expect { described_class.call(page) }.to raise_error(Magicard::MtgApi::HttpError)
    end
  end
end
