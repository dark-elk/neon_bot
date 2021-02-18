# frozen_string_literal: true

require_relative 'enviroment'

app Container['http.app']

stdout_redirect nil, '/dev/null'

bind "tcp://#{Container[:settings].http_host}:#{Container[:settings].http_port}"

lowlevel_error_handler do |e, env|
  correlation = env[Datadog::Contrib::Rack::TraceMiddleware::RACK_REQUEST_SPAN]
  hash = {
    trace_id: correlation.trace_id.to_s,
    span_id: correlation.span_id.to_s
  }
  Container[:logger].error(exception: e, dd: hash)
  [500, {}, ['Unexpected error occured']]
end

environment Container[:settings].project_env
