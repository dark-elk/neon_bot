# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.1'

# HTTP layer
gem 'hanami-api'
gem 'hanami-controller', git: 'https://github.com/hanami/controller.git', tag: 'v2.0.0.alpha1'
gem 'hanami-validations', git: 'https://github.com/hanami/validations.git', tag: 'v2.0.0.alpha1'
gem 'puma', '~> 5.1'

# Persistance layer
gem 'pg'
gem 'rom', '~> 5.2.4'
gem 'rom-sql', '~> 3.2.0'
gem 'sequel', '~> 4.49.0'

# Monitoring and logging
gem 'rollbar'
gem 'semantic_logger'

# Dependency managment
gem 'dry-system'

# Business logic section
gem 'dry-monads'
gem 'dry-validation'

# Background processing
gem 'que'

# Other
gem 'bigdecimal', '1.4.2'
gem 'deep_merge'
gem 'dotenv', '~> 2.4'
gem 'dry-cli'
gem 'rake'

# 3rd party api
gem 'telegram-bot-ruby'

group :development do
  gem 'pry'
end

group :test, :development do
  # Data generation and cleanup
  gem 'database_cleaner'
  gem 'database_cleaner-sequel'

  # Style check
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false

  gem 'rom-factory'
end
