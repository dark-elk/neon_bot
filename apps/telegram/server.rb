# frozen_string_literal: true

Container[:telegram_bot].run do |bot|
  dispatcher = Dispatcher.new(bot)

  bot.listen do |msg|
    bot.logger.info(msg)
    dispatcher.call(msg)
  end
end
