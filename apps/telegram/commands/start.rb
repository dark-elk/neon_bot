# frozen_string_literal: true

module Commands
  class Start < Base
    WELCOME_TEXT = 'Hello'

    private

    def handle_call(message)
      send_message(
          chat_id: message.chat.id,
          text: WELCOME_TEXT,
          parse_mode: :markdown
      )
    end
  end
end
