# frozen_string_literal: true

require 'semantic_logger'
require 'deep_merge'

module Datadog
  class LogFormatter < SemanticLogger::Formatters::Json
    def call(log, logger)
      correlation = Datadog.tracer.active_correlation
      hash = {
        # To preserve precision during JSON serialization, use strings for large numbers
        trace_id: correlation.trace_id.to_s,
        span_id: correlation.span_id.to_s,
        env: correlation.env.to_s,
        service: correlation.service.to_s,
        version: correlation.version.to_s
      }
      payload = log.payload || {}
      log.payload = payload.deep_merge(dd: hash) if payload.is_a?(Hash)
      super
    end
  end
end
