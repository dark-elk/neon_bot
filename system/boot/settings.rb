# frozen_string_literal: true

require 'dry/system/components'

Container.boot(:settings, from: :system) do
  settings do
    Types = Core::Types

    key :project_name, Types::String.default('ruby-boilerplate')
    key :dd_service, Types::String.default('ruby-boilerplate')
    key :project_env, Types::String
    key :project_version, Types::String
    key :project_apps, Types::ProjectApps

    key :database_url, Types::String.constrained(filled: true)
    # key :database_connection_validation_timeout, Types::Coercible::Int.optional # in seconds

    key :logger_formatter, Types::String.optional
    key :logger_level, Types::LoggerLevel

    key :bugsnag_key, Types::String
    key :http_port, Types::String.default('9292')
    key :http_host, Types::String.default('0.0.0.0')
  end
end
