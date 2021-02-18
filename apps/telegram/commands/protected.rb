# frozen_string_literal: true

module Commands
  class Protected < Base
    include Import[:settings]

    def call(message)
      if settings.telegram_authorized_ids.include? message.chat.id.to_s
        super
      else
        send_message(
            chat_id: message.chat.id,
            text: 'Unauthorized',
        )
      end
    end
  end
end
