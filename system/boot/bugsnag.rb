# frozen_string_literal: true

Container.boot(:bugsnag) do |container|
  init do
    use :settings

    Bugsnag.configure do |config|
      config.api_key = container[:settings].bugsnag_key
      config.auto_notify = %w(production staging).include?(container[:settings].project_env)
      config.notify_release_stages = %w(production staging)
      config.app_type = container[:settings].project_apps.first
      config.release_stage = container[:settings].project_env
      config.delivery_method = :synchronous
      config.logger = container[:logger]
      config.app_version = container[:settings].project_version
    end
  end
end
