# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Magicard::CLI do
  context 'load command' do
    let(:configuration) do
      {
        cache_path:  Magicard::CLI::CACHE_PATH,
        force:       false,
        concurrency: concurrency
      }
    end
    let(:concurrency) { 1 }
    let(:cli_output) { '' }

    context 'with default concurrency' do
      before { ARGV.replace(%w[load]) }

      it 'runs loader' do
        expect(Magicard::Loader).to receive(:new).with(configuration).and_return(double(call: nil))
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end

    context 'with exception from loader' do
      let(:cli_output) { "error\n" }

      before { ARGV.replace(%w[load]) }

      it 'prints error' do
        expect(Magicard::Loader).to receive(:new).with(configuration).and_raise(Magicard::Error.new('error'))
        expect { Magicard::CLI.start }
          .to output(cli_output)
          .to_stdout
          .and raise_error(SystemExit)
      end
    end

    context 'with specified concurrency' do
      let(:concurrency) { 2 }

      before { ARGV.replace(%w[load 2]) }

      it 'prints error' do
        expect(Magicard::Loader).to receive(:new).with(configuration).and_return(double(call: nil))
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end
  end

  context 'forceload command' do
    let(:configuration) do
      {
        cache_path:  Magicard::CLI::CACHE_PATH,
        force:       true,
        concurrency: concurrency
      }
    end
    let(:concurrency) { 1 }
    let(:cli_output) { '' }

    context 'with default concurrency' do
      before { ARGV.replace(%w[forceload]) }

      it 'runs loader' do
        expect(Magicard::Loader).to receive(:new).with(configuration).and_return(double(call: nil))
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end

    context 'with exception from loader' do
      let(:cli_output) { "error\n" }

      before { ARGV.replace(%w[forceload]) }

      it 'prints error' do
        expect(Magicard::Loader).to receive(:new).with(configuration).and_raise(Magicard::Error.new('error'))
        expect { Magicard::CLI.start }
          .to output(cli_output)
          .to_stdout
          .and raise_error(SystemExit)
      end
    end

    context 'with specified concurrency' do
      let(:concurrency) { 2 }

      before { ARGV.replace(%w[forceload 2]) }

      it 'prints error' do
        expect(Magicard::Loader).to receive(:new).with(configuration).and_return(double(call: nil))
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end
  end

  context 'get command' do
    let(:configuration) { { cache_path: Magicard::CLI::CACHE_PATH } }
    let(:getter_double) { double(call: double(to_json: '{a: 1}')) }

    context 'with type1' do
      before { ARGV.replace(%w[get type1]) }

      let(:cli_output) { "{a: 1}\n" }

      it 'runs getter' do
        expect(Magicard::Getter::Type1).to receive(:new).with(configuration).and_return(getter_double)
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end

    context 'with type2' do
      before { ARGV.replace(%w[get type2]) }

      let(:cli_output) { "{a: 1}\n" }

      it 'runs getter' do
        expect(Magicard::Getter::Type2).to receive(:new).with(configuration).and_return(getter_double)
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end

    context 'with type3' do
      before { ARGV.replace(%w[get type3]) }

      let(:cli_output) { "{a: 1}\n" }

      it 'runs getter' do
        expect(Magicard::Getter::Type3).to receive(:new).with(configuration).and_return(getter_double)
        expect { Magicard::CLI.start }.to output(cli_output).to_stdout
      end
    end

    context 'with unknown type' do
      before { ARGV.replace(%w[get unknown]) }

      let(:cli_output) { "Unknown get type unknown\n" }

      it 'prints error' do
        expect { Magicard::CLI.start }
          .to output(cli_output)
          .to_stdout
          .and raise_error(SystemExit)
      end
    end

    context 'with exception from getter' do
      let(:cli_output) { "error\n" }

      before { ARGV.replace(%w[get type1]) }

      it 'prints error' do
        expect(Magicard::Getter::Type1).to receive(:new).with(configuration).and_raise(Magicard::Error.new('error'))
        expect { Magicard::CLI.start }
          .to output(cli_output)
          .to_stdout
          .and raise_error(SystemExit)
      end
    end
  end

  context 'help command' do
    let(:cli_output) do
      <<~HEREDOC
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

    before { ARGV.replace(['help']) }

    it 'prints help' do
      expect { Magicard::CLI.start }.to output(cli_output).to_stdout
    end
  end

  context 'version command' do
    let(:cli_output) { "0.1.0\n" }

    before { ARGV.replace(['version']) }

    it 'prints version' do
      expect { Magicard::CLI.start }.to output(cli_output).to_stdout
    end
  end

  context 'unknown command' do
    let(:cli_output) { "Unknown command unknown\n" }

    before { ARGV.replace(['unknown']) }

    it 'prints error' do
      expect { Magicard::CLI.start }
        .to output(cli_output)
        .to_stdout
        .and raise_error(SystemExit)
    end
  end
end
