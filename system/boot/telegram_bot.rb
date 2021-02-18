# frozen_string_literal: true
require 'telegram/bot'

Container.boot(:telegram_bot) do |container|
  init do
    use :settings
    use :logger

    config = [Container[:settings].telegram_bot_api_token, { logger: Container[:logger] }]
    container.register(:telegram_bot, Telegram::Bot::Client.new(*config))
  end
end
