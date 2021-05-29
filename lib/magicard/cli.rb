# frozen_string_literal: true

module Magicard
  module CLI
    extend self

    CACHE_PATH = 'tmp/cards'

    def start
      command = ARGV[0]

      case command
      when 'load'
        run_loader(force: false)
      when 'forceload'
        run_loader(force: true)
      when 'get'
        call_getter
      when 'help', '--help', '-h'
        print_help
      when 'version', '--version', '-v'
        puts Magicard::VERSION
      else
        puts "Unknown command #{command}"
        exit(1)
      end
    end

    private def run_loader(force:)
      concurrency = ARGV[1].to_i
      concurrency = 1 if concurrency.zero? || concurrency >= 100

      Magicard::Loader.new(cache_path: CACHE_PATH, force: force, concurrency: concurrency).call
    rescue Magicard::Error => e
      puts e.message
      exit(1)
    end

    private def call_getter
      configuration = { cache_path: CACHE_PATH }
      type          = ARGV[1]

      case type
      when 'type1'
        puts Magicard::Getter::Type1.new(configuration).call.to_json
      when 'type2'
        puts Magicard::Getter::Type2.new(configuration).call.to_json
      when 'type3'
        puts Magicard::Getter::Type3.new(configuration).call.to_json
      else
        puts "Unknown get type #{type}"
        exit(1)
      end
    rescue Magicard::Error => e
      puts e.message
      exit(1)
    end

    private def print_help
      puts <<~HEREDOC
        CLI tools for getting info for MTG cards

        Usage:
          bin/magicard load 1           load data from MTG-API to local. With maximum number of parallel downloads. The default is 1
          bin/magicard forceload 1      load data from MTG-API to local. With cache clean
          bin/magicard get type1        return a list of Cards grouped by `set`
          bin/magicard get type2        return a list of Cards grouped by `set` and within each `set` grouped by `rarity`
          bin/magicard get type3        return a list of cards from the `Khans of Tarkir` set that ONLY have the colours `red` AND `blue`
          bin/magicard -v/--version     print tool version
          bin/magicard -h/--help/help   print this help
      HEREDOC
    end
  end
end
