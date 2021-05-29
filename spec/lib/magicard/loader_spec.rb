# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::Loader do
  subject(:service) { described_class.new(cache_path: cache_path, force: force, concurrency: concurrency) }

  let(:cache_path) { 'test' }
  let(:force) { false }
  let(:concurrency) { 1 }
  let(:cards_total) { 200 }

  let(:api_response) do
    {
      content:     'content',
      cards_total: cards_total
    }
  end

  let(:service_output) do
    <<~HEREDOC
      Pages for download: 2
      Downloading page 2...
      Download completed
    HEREDOC
  end

  before do
    allow(Dir).to receive(:exist?).with(cache_path).and_return(true)
    allow(Dir).to receive(:empty?).with(cache_path).and_return(true)
    allow(Magicard::MtgApi::CardsGet).to receive(:call).with(1).and_return(api_response)
    allow(Magicard::MtgApi::CardsGet).to receive(:call).with(2).and_return(api_response)
    allow(File).to receive(:write).with('test/1.json', 'content')
    allow(File).to receive(:write).with('test/2.json', 'content')
  end

  it 'returns correct output' do
    expect { service.call }.to output(service_output).to_stdout
  end

  context 'cache_path validations' do
    context 'when cache_path not exists on fs' do
      before do
        allow(Dir).to receive(:exist?).with(cache_path).and_return(false)
      end

      it 'creates directory' do
        expect(FileUtils).to receive(:mkdir_p).with(cache_path)

        expect { service.call }.to output(service_output).to_stdout
      end
    end

    context 'when cache_path not empty and force is true' do
      let(:force) { true }

      before do
        allow(Dir).to receive(:empty?).with(cache_path).and_return(false)
      end

      it 'raises error' do
        expect { service.call }.to raise_error(Magicard::Error)
      end
    end
  end

  context 'mtg-api error' do
    let(:cards_total) { 100 }

    before do
      allow(Magicard::MtgApi::CardsGet).to receive(:call).and_raise(Magicard::MtgApi::HttpError)
    end

    it 'raises error' do
      expect { service.call }.to raise_error(Magicard::Error)
    end
  end
end
