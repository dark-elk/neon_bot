# frozen_string_literal: true

require 'fileutils'

Container.boot(:que) do |container|
  unless container[:settings].project_apps.include?('rake')
    init do
      use :persistence

      require 'que'
      Que.connection = container['persistence.container'].gateways[:default].connection
      Que.use_prepared_statements = false
      Que.logger = container[:logger]

      # rubocop:disable Metrics/BlockNesting
      Que.error_notifier = proc do |error, job|
        Bugsnag.notify(error) do |report|
          report.add_tab(:job, job)
          report.app_type = 'que'
        end

        if error.is_a?(PG::UnableToSend)
          logger.fatal 'Lost connection to the database, exiting'
          exit 1
        end
      end
      # rubocop:enable Metrics/BlockNesting

      # Used by k8s readiness probe
      FileUtils.touch('/tmp/que-ready')
    end
  end
end
