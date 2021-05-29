# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::Getter::ActsAsGetter do
  let(:dummy_class) do
    Class.new do
      include Magicard::Getter::ActsAsGetter

      def call
        process_card([]) do |card, result|
          result << card
        end
      end
    end
  end

  let(:cache_path) { 'spec/fixtures/acts_as_getter' }
  let(:result) { [{ 'name' => 'test' }] }

  it 'returns correct result' do
    expect(dummy_class.new(cache_path: cache_path).call).to eq(result)
  end

  context 'local cache doesnt exist' do
    let(:cache_path) { 'test' }

    before do
      allow(Dir).to receive(:glob).with("#{cache_path}/*.json").and_return([])
    end

    it 'raises exception' do
      expect { dummy_class.new(cache_path: cache_path).call }.to raise_error(Magicard::Error)
    end
  end
end
