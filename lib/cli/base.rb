# frozen_string_literal: true

require 'dry/cli'

module Cli
  module Base
    extend Dry::CLI::Registry

    class Version < Dry::CLI::Command
      desc 'Print version'

      def call(*)
        puts '1.0.0'
      end
    end

    class Server < Dry::CLI::Command
      desc 'start http server'

      def call(*)
        ENV['PROJECT_APPS'] = 'http,telegram'

        system('bundle exec puma')
      end
    end

    class Console < Dry::CLI::Command
      desc 'Start IRB session'

      def call(*)
        require 'irb'
        require_relative '../../config/enviroment'

        ENV['PROJECT_APPS'] = 'http,rabbitmq'
        ARGV.clear
        IRB.start
      end
    end

    class BackgroundProcessing < Dry::CLI::Command
      desc 'Start que server'

      def call(*)
        ENV['PROJECT_APPS'] = ''

        system('bundle exec que ./config/enviroment.rb')
      end
    end

    register 'version',  Version, aliases: %w(v -v --version)
    register 'server',   Server, aliases: ['s']
    register 'console',  Console, aliases: ['c']
    register 'que',      BackgroundProcessing
  end
end
