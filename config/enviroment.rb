# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env', ".env.#{ENV['APP_ENV']}")

require_relative '../system/container'
Container.finalize!
