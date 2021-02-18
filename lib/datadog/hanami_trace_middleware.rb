# frozen_string_literal: true

# Datadog rack tracer sends resource names like `GET 200` or `POST 202`, which are useless.
# I changed it so that datadog sends request paths as resource names.
# Note that it affects usage of `middleware_names` configration option.
module Datadog
  module Contrib
    module Rack
      class HanamiTraceMiddleware < TraceMiddleware
        attr_reader :router

        def initialize(app, router:)
          super(app)

          @router = router
        end

        def resource_name_for(env, _status)
          route = router.recognize(env['REQUEST_PATH'], env['REQUEST_METHOD'])

          if route.routable? && route.endpoint.is_a?(Hanami::Action)
            route.endpoint.class.to_s
          else
            "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}"
          end
        end
      end
    end
  end
end
