# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env', ".env.#{ENV['APP_ENV']}")

require 'ddtrace'
require 'bugsnag'
require_relative '../system/container'
Container.finalize!
