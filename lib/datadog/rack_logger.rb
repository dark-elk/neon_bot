# frozen_string_literal: true

require 'rack/common_logger'

module Datadog
  # Rack logger for Hanami.app
  #
  # @since 1.0.0
  # @api private
  class RackLogger < Rack::CommonLogger
    private

    # @since 1.0.0
    # @api private
    HTTP_VERSION         = 'HTTP_VERSION'

    # @since 1.0.0
    # @api private
    REQUEST_METHOD       = 'REQUEST_METHOD'

    # @since 1.0.0
    # @api private
    HTTP_X_FORWARDED_FOR = 'HTTP_X_FORWARDED_FOR'

    # @since 1.0.0
    # @api private
    REMOTE_ADDR          = 'REMOTE_ADDR'

    # @since 1.0.0
    # @api private
    SCRIPT_NAME          = 'SCRIPT_NAME'

    # @since 1.0.0
    # @api private
    PATH_INFO            = 'PATH_INFO'

    # @since 1.0.0
    # @api private
    RACK_ERRORS          = 'rack.errors'

    # @since 1.1.0
    # @api private
    QUERY_HASH           = 'rack.request.query_hash'

    # @since 1.1.0
    # @api private
    FORM_HASH            = 'rack.request.form_hash'

    # @since 1.3.0
    # @api private
    ROUTER_PARSED_BODY   = 'router.parsed_body'

    # @since 1.0.0
    # @api private
    #
    # rubocop:disable Metrics/MethodLength
    def log(env, status, header, began_at)
      return if env[PATH_INFO] == '/health'

      now    = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      length = extract_content_length(header)

      ips = env[HTTP_X_FORWARDED_FOR]&.split(',')&.map(&:strip)
      msg = Hash[
        http: {
          status_code: status,
          method: env[REQUEST_METHOD],
          url_details: {
            path: env[SCRIPT_NAME] + env[PATH_INFO].to_s,
            queryString: env.fetch(QUERY_HASH, {})
          },
          version: env[HTTP_VERSION].split('/').last
        },
        network: {
          bytes_written: length,
          client: {
            ip: ips&.first,
            ips: ips
          }
        },
        params: extract_params(env),
        duration: now - began_at
      ]

      logger = @logger
      correlation = env[Datadog::Contrib::Rack::TraceMiddleware::RACK_REQUEST_SPAN]
      dd = {
        trace_id: correlation.trace_id.to_s,
        span_id: correlation.span_id.to_s
      }
      logger.info(msg.merge(dd: dd))
    end
    # rubocop:enable Metrics/MethodLength

    # @since 1.1.0
    # @api private
    def extract_params(env)
      result = env.fetch(FORM_HASH, {})
      result.merge(env.fetch(ROUTER_PARSED_BODY, {}))
    end
  end
end
