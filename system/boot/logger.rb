# frozen_string_literal: true

require 'semantic_logger/sync'
require 'datadog/log_formatter'

Container.boot(:logger) do |container|
  init do
    use :settings

    case Container[:settings].logger_formatter
    when 'datadog'
      SemanticLogger.add_appender(io: logger_io, formatter: Datadog::LogFormatter.new)
    when 'json'
      SemanticLogger.add_appender(io: logger_io, formatter: :json)
    else
      SemanticLogger.add_appender(io: logger_io)
    end

    SemanticLogger.default_level = container[:settings].logger_level
    SemanticLogger.application = container[:settings].project_name
    SemanticLogger.environment = container.config.env

    container.register(:logger, SemanticLogger[container[:settings].project_name])
  end

  # detect default logger IO output
  def logger_io
    ENV['PROJECT_ENV'] == 'test' ? StringIO.new : STDOUT
  end
end
