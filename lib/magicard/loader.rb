# frozen_string_literal: true

require 'fileutils'

module Magicard
  class Loader
    DEFAULT_PER_PAGE  = 100
    DEFAULT_RATELIMIT = 1000

    def initialize(cache_path:, force:, concurrency:)
      @cache_path  = cache_path
      @concurrency = concurrency
      @force       = force
      @threads     = []
    end

    def call
      validate_cache_path!

      response = download_page(1)
      pages    = (response[:cards_total] / DEFAULT_PER_PAGE.to_f).ceil

      puts "Pages for download: #{pages}"

      start_parallel_download(pages)

      puts 'Download completed'
    end

    private def validate_cache_path!
      FileUtils.mkdir_p(@cache_path) unless Dir.exist?(@cache_path)

      if @force
        FileUtils.rm_rf(Dir["#{@cache_path}/*"]) unless Dir.empty?(@cache_path)
      end

      unless Dir.empty?(@cache_path)
        raise(
          Magicard::Error,
          "Local cache found. Please run `bin/magicard forceload #{@concurrency}` for invalidate existed cache."
        )
      end
    end

    def start_parallel_download(pages_count)
      @queue = (2..pages_count).to_a

      @concurrency.times do
        @threads << Thread.new do
          loop do
            break if @queue.empty?

            page = @queue.shift

            puts "Downloading page #{page}..."

            download_page(page)
          end
        end
      end

      @threads.each(&:join)
    end

    def download_page(page)
      response = Magicard::MtgApi::CardsGet.call(page)

      File.write("#{@cache_path}/#{page}.json", response[:content])

      response
    rescue Magicard::MtgApi::HttpError => e
      raise(Magicard::Error, "Can't load page #{page}: #{e.message}")
    end
  end
end
