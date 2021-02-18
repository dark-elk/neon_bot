# frozen_string_literal: true

Container.boot(:datadog) do |container|
  init do
    # Make sure rack is loaded, because the Datadog's rack integration
    # won't work otherwise.
    require 'rack'

    Datadog.configure do |c|
      c.logger = container[:logger]

      # service_name for all integrations should be the PROJECT_NAME
      c.use :rack, service_name: container[:settings].dd_service
      c.use :sequel, service_name: "#{container[:settings].dd_service}-db"

      # you can add more integrations here, like faraday or sidekiq or etc
    end
  end
end
